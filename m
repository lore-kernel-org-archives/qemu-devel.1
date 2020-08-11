Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7062C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808FF204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808FF204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VK5-0002f9-IH
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1k5VHh-0000Rl-0J
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:29:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1k5VHe-0003B6-3o
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:29:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B0480B169;
 Tue, 11 Aug 2020 14:30:05 +0000 (UTC)
From: mwilck@suse.com
To: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3] virtio-rng: return available data with O_NONBLOCK
Date: Tue, 11 Aug 2020 16:28:21 +0200
Message-Id: <20200811142821.12323-1-mwilck@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=mwilck@suse.com;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:05:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: virtualization@lists.linux-foundation.org, Martin Wilck <mwilck@suse.com>,
 Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Martin Wilck <mwilck@suse.com>

If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
non-blocking read() to retrieve random data, it ends up in a tight
loop with poll() always returning POLLIN and read() returning EAGAIN.
This repeats forever until some process makes a blocking read() call.
The reason is that virtio_read() always returns 0 in non-blocking mode,
even if data is available. Worse, it fetches random data from the
hypervisor after every non-blocking call, without ever using this data.

The following test program illustrates the behavior and can be used
for testing and experiments. The problem will only be seen if all
tasks use non-blocking access; otherwise the blocking reads will
"recharge" the random pool and cause other, non-blocking reads to
succeed at least sometimes.

/* Whether to use non-blocking mode in a task, problem occurs if CONDITION is 1 */
//#define CONDITION (getpid() % 2 != 0)

static volatile sig_atomic_t stop;
static void handler(int sig __attribute__((unused))) { stop = 1; }

static void loop(int fd, int sec)
{
	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
	int size, rc, rd;

	srandom(getpid());
	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1)
		perror("fcntl");
	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);

	for(;;) {
		char buf[size];

		if (stop)
			break;
		rc = poll(&pfd, 1, sec);
		if (rc > 0) {
			rd = read(fd, buf, sizeof(buf));
			if (rd == -1 && errno == EAGAIN)
				eagains++;
			else if (rd == -1)
				errors++;
			else {
				succ++;
				bytes += rd;
				write(1, buf, sizeof(buf));
			}
		} else if (rc == -1) {
			if (errno != EINTR)
				perror("poll");
			break;
		} else
			fprintf(stderr, "poll: timeout\n");
	}
	fprintf(stderr,
		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes read, %lu success, %lu eagain, %lu errors\n",
		getpid(), CONDITION ? "non-" : "", size, sec, bytes, succ, eagains, errors);
}

int main(void)
{
	int fd;

	fork(); fork();
	fd = open("/dev/hwrng", O_RDONLY);
	if (fd == -1) {
		perror("open");
		return 1;
	};
	signal(SIGALRM, handler);
	alarm(SECONDS);
	loop(fd, SECONDS);
	close(fd);
	wait(NULL);
	return 0;
}

void loop(int fd)
{
        struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
        int rc;
        unsigned int n;

        for (n = LOOPS; n > 0; n--) {
                struct pollfd pfd = pfd0;
                char buf[SIZE];

                rc = poll(&pfd, 1, 1);
                if (rc > 0) {
                        int rd = read(fd, buf, sizeof(buf));

                        if (rd == -1)
                                perror("read");
                        else
                                printf("read %d bytes\n", rd);
                } else if (rc == -1)
                        perror("poll");
                else
                        fprintf(stderr, "timeout\n");

        }
}

int main(void)
{
        int fd;

        fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
        if (fd == -1) {
                perror("open");
                return 1;
        };
        loop(fd);
        close(fd);
        return 0;
}

This can be observed in the real word e.g. with nested qemu/KVM virtual
machines, if both the "outer" and "inner" VMs have a virtio-rng device.
If the "inner" VM requests random data, qemu running in the "outer" VM
uses this device in a non-blocking manner like the test program above.

Fix it by returning available data if a previous hypervisor call has
completed. I tested this patch with the program above, and with rng-tools.

v2 -> v3: Simplified the implementation as suggested by Laurent Vivier

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/char/hw_random/virtio-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a90001e02bf7..8eaeceecb41e 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -65,7 +65,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 		register_buffer(vi, buf, size);
 	}
 
-	if (!wait)
+	if (!wait && !completion_done(&vi->have_data))
 		return 0;
 
 	ret = wait_for_completion_killable(&vi->have_data);
@@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 
 	vi->busy = false;
 
-	return vi->data_avail;
+	return min_t(size_t, size, vi->data_avail);
 }
 
 static void virtio_cleanup(struct hwrng *rng)
-- 
2.28.0


