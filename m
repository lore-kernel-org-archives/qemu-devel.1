Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1266C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E46C206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fpb4hENq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E46C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VUo-0007oV-Oa
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1k5VUD-0007O3-Va
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:42:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1k5VUC-0004oe-2v
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597156963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UIUkunl9JQebhCaMqZI0eNoKo1oNJsUIOnIbZMHGat4=;
 b=Fpb4hENqU9gX4Dh6U95XfI4oY5BzGne6kXrCakuHMS+9xQ/pvZtztIVmlfslWe4W/W1YaE
 D+dyED8PNQtLu/pvd8nUqxuTH1p/of1K5lSUZVPsWcMmqNdDv/asZIa7chKJwgJeOXDEtx
 Y8Wzt3JtFVFZUM4wzLZS/F5ONhalczw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-w8Q4N_N8NUSzY88bmHrFEg-1; Tue, 11 Aug 2020 10:42:39 -0400
X-MC-Unique: w8Q4N_N8NUSzY88bmHrFEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0651005504;
 Tue, 11 Aug 2020 14:42:38 +0000 (UTC)
Received: from [10.36.112.235] (ovpn-112-235.ams2.redhat.com [10.36.112.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02E175D9D7;
 Tue, 11 Aug 2020 14:42:32 +0000 (UTC)
Subject: Re: [PATCH v3] virtio-rng: return available data with O_NONBLOCK
To: mwilck@suse.com, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20200811142821.12323-1-mwilck@suse.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
Date: Tue, 11 Aug 2020 16:42:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811142821.12323-1-mwilck@suse.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/08/2020 16:28, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
> non-blocking read() to retrieve random data, it ends up in a tight
> loop with poll() always returning POLLIN and read() returning EAGAIN.
> This repeats forever until some process makes a blocking read() call.
> The reason is that virtio_read() always returns 0 in non-blocking mode,
> even if data is available. Worse, it fetches random data from the
> hypervisor after every non-blocking call, without ever using this data.
> 
> The following test program illustrates the behavior and can be used
> for testing and experiments. The problem will only be seen if all
> tasks use non-blocking access; otherwise the blocking reads will
> "recharge" the random pool and cause other, non-blocking reads to
> succeed at least sometimes.
> 
> /* Whether to use non-blocking mode in a task, problem occurs if CONDITION is 1 */
> //#define CONDITION (getpid() % 2 != 0)
> 
> static volatile sig_atomic_t stop;
> static void handler(int sig __attribute__((unused))) { stop = 1; }
> 
> static void loop(int fd, int sec)
> {
> 	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
> 	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
> 	int size, rc, rd;
> 
> 	srandom(getpid());
> 	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1)
> 		perror("fcntl");
> 	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);
> 
> 	for(;;) {
> 		char buf[size];
> 
> 		if (stop)
> 			break;
> 		rc = poll(&pfd, 1, sec);
> 		if (rc > 0) {
> 			rd = read(fd, buf, sizeof(buf));
> 			if (rd == -1 && errno == EAGAIN)
> 				eagains++;
> 			else if (rd == -1)
> 				errors++;
> 			else {
> 				succ++;
> 				bytes += rd;
> 				write(1, buf, sizeof(buf));
> 			}
> 		} else if (rc == -1) {
> 			if (errno != EINTR)
> 				perror("poll");
> 			break;
> 		} else
> 			fprintf(stderr, "poll: timeout\n");
> 	}
> 	fprintf(stderr,
> 		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes read, %lu success, %lu eagain, %lu errors\n",
> 		getpid(), CONDITION ? "non-" : "", size, sec, bytes, succ, eagains, errors);
> }
> 
> int main(void)
> {
> 	int fd;
> 
> 	fork(); fork();
> 	fd = open("/dev/hwrng", O_RDONLY);
> 	if (fd == -1) {
> 		perror("open");
> 		return 1;
> 	};
> 	signal(SIGALRM, handler);
> 	alarm(SECONDS);
> 	loop(fd, SECONDS);
> 	close(fd);
> 	wait(NULL);
> 	return 0;
> }
> 
> void loop(int fd)
> {
>         struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
>         int rc;
>         unsigned int n;
> 
>         for (n = LOOPS; n > 0; n--) {
>                 struct pollfd pfd = pfd0;
>                 char buf[SIZE];
> 
>                 rc = poll(&pfd, 1, 1);
>                 if (rc > 0) {
>                         int rd = read(fd, buf, sizeof(buf));
> 
>                         if (rd == -1)
>                                 perror("read");
>                         else
>                                 printf("read %d bytes\n", rd);
>                 } else if (rc == -1)
>                         perror("poll");
>                 else
>                         fprintf(stderr, "timeout\n");
> 
>         }
> }
> 
> int main(void)
> {
>         int fd;
> 
>         fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
>         if (fd == -1) {
>                 perror("open");
>                 return 1;
>         };
>         loop(fd);
>         close(fd);
>         return 0;
> }
> 
> This can be observed in the real word e.g. with nested qemu/KVM virtual
> machines, if both the "outer" and "inner" VMs have a virtio-rng device.
> If the "inner" VM requests random data, qemu running in the "outer" VM
> uses this device in a non-blocking manner like the test program above.
> 
> Fix it by returning available data if a previous hypervisor call has
> completed. I tested this patch with the program above, and with rng-tools.
> 
> v2 -> v3: Simplified the implementation as suggested by Laurent Vivier
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index a90001e02bf7..8eaeceecb41e 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -65,7 +65,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  		register_buffer(vi, buf, size);
>  	}
>  
> -	if (!wait)
> +	if (!wait && !completion_done(&vi->have_data))
>  		return 0;
>  
>  	ret = wait_for_completion_killable(&vi->have_data);
> @@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  
>  	vi->busy = false;
>  
> -	return vi->data_avail;
> +	return min_t(size_t, size, vi->data_avail);
>  }
>  
>  static void virtio_cleanup(struct hwrng *rng)
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


