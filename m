Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8829C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F89A2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVeJjHhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F89A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAuXH-0002XD-Uj
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kAuWE-00023H-JU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kAuWB-0005Pq-UP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598444825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkkQI/wYXENlCW1Jvqq6bXzYIJuw8NEg9m3IFD6BwCs=;
 b=hVeJjHhLORhsrr3dhEKoGSAT1FqsOU7bQUC1/R0Dwe4W8gtL8jDAYZIR7Hag4mr/Zxe6+J
 4I4Oksl2GMqVqv6L9+dFAWoA80QilFLsV8J/XlSq4aVPEGH39vdHit0wUbYGYMfI/KWe09
 P+3q5yrCk587SrZxoqDpRnwBpfpOsLY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-rIY7T5n3O2KyXi9MHBse8A-1; Wed, 26 Aug 2020 08:27:04 -0400
X-MC-Unique: rIY7T5n3O2KyXi9MHBse8A-1
Received: by mail-wm1-f72.google.com with SMTP id g79so847611wmg.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rkkQI/wYXENlCW1Jvqq6bXzYIJuw8NEg9m3IFD6BwCs=;
 b=RNCl9TJhVRWYW1OYL3arWtS5YRggD1i58tLYjF9EmhROUcQj0Kqri3tIm41hW2D2CU
 q+JIpP0k/MHhQ7Y9x4WeIZPZt1jmqlRILOMawTrulC6HThhpU0t2J/oDFufjzHXDHuYb
 0vtxH5kFl4cb02LSX1QooXeiT5uGBroZsTqzouX446SD0x2dnauF10uR6dQNzeXbh6Rd
 yvZWWDv+Dy3p4kuoDyPVNtzUNeoJEFkoi9Z8mXrvZ7iZr9JzGEM4+jEI3zOQ7NVFdI+z
 OXSTT9VWYEncxGgSkVpFcI1fEkUL9ByEoZ3YX3bpXT//ShiEwB3G8J3r0X6gD0yA6Ool
 TLqw==
X-Gm-Message-State: AOAM530H31sELUf7QgYcKhnZO+ELHg85rrD9ndK25vnZCbdDXT24EJzw
 EJbLUYIIezDnMQQdUoS4nOvyxc37Kc3k6IpXTbxhJfsqHlmKExmI+w+hnuXd6cyzzhdkfB1FQMc
 NQhZ6I677FNLcyj0=
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16012165wru.9.1598444822774; 
 Wed, 26 Aug 2020 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0xbC9dzkRh8kdZb85jaCpn6wU2yctKY2q7jCpoCcHlZEv5/EKsYUsT9W3INNqvjYLG61L9g==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16012138wru.9.1598444822448; 
 Wed, 26 Aug 2020 05:27:02 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id v4sm4912619wml.46.2020.08.26.05.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 05:27:01 -0700 (PDT)
Date: Wed, 26 Aug 2020 08:26:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200826082613-mutt-send-email-mst@kernel.org>
References: <20200811142821.12323-1-mwilck@suse.com>
 <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, mwilck@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 04:42:32PM +0200, Laurent Vivier wrote:
> On 11/08/2020 16:28, mwilck@suse.com wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
> > non-blocking read() to retrieve random data, it ends up in a tight
> > loop with poll() always returning POLLIN and read() returning EAGAIN.
> > This repeats forever until some process makes a blocking read() call.
> > The reason is that virtio_read() always returns 0 in non-blocking mode,
> > even if data is available. Worse, it fetches random data from the
> > hypervisor after every non-blocking call, without ever using this data.
> > 
> > The following test program illustrates the behavior and can be used
> > for testing and experiments. The problem will only be seen if all
> > tasks use non-blocking access; otherwise the blocking reads will
> > "recharge" the random pool and cause other, non-blocking reads to
> > succeed at least sometimes.
> > 
> > /* Whether to use non-blocking mode in a task, problem occurs if CONDITION is 1 */
> > //#define CONDITION (getpid() % 2 != 0)
> > 
> > static volatile sig_atomic_t stop;
> > static void handler(int sig __attribute__((unused))) { stop = 1; }
> > 
> > static void loop(int fd, int sec)
> > {
> > 	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
> > 	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
> > 	int size, rc, rd;
> > 
> > 	srandom(getpid());
> > 	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1)
> > 		perror("fcntl");
> > 	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);
> > 
> > 	for(;;) {
> > 		char buf[size];
> > 
> > 		if (stop)
> > 			break;
> > 		rc = poll(&pfd, 1, sec);
> > 		if (rc > 0) {
> > 			rd = read(fd, buf, sizeof(buf));
> > 			if (rd == -1 && errno == EAGAIN)
> > 				eagains++;
> > 			else if (rd == -1)
> > 				errors++;
> > 			else {
> > 				succ++;
> > 				bytes += rd;
> > 				write(1, buf, sizeof(buf));
> > 			}
> > 		} else if (rc == -1) {
> > 			if (errno != EINTR)
> > 				perror("poll");
> > 			break;
> > 		} else
> > 			fprintf(stderr, "poll: timeout\n");
> > 	}
> > 	fprintf(stderr,
> > 		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes read, %lu success, %lu eagain, %lu errors\n",
> > 		getpid(), CONDITION ? "non-" : "", size, sec, bytes, succ, eagains, errors);
> > }
> > 
> > int main(void)
> > {
> > 	int fd;
> > 
> > 	fork(); fork();
> > 	fd = open("/dev/hwrng", O_RDONLY);
> > 	if (fd == -1) {
> > 		perror("open");
> > 		return 1;
> > 	};
> > 	signal(SIGALRM, handler);
> > 	alarm(SECONDS);
> > 	loop(fd, SECONDS);
> > 	close(fd);
> > 	wait(NULL);
> > 	return 0;
> > }
> > 
> > void loop(int fd)
> > {
> >         struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
> >         int rc;
> >         unsigned int n;
> > 
> >         for (n = LOOPS; n > 0; n--) {
> >                 struct pollfd pfd = pfd0;
> >                 char buf[SIZE];
> > 
> >                 rc = poll(&pfd, 1, 1);
> >                 if (rc > 0) {
> >                         int rd = read(fd, buf, sizeof(buf));
> > 
> >                         if (rd == -1)
> >                                 perror("read");
> >                         else
> >                                 printf("read %d bytes\n", rd);
> >                 } else if (rc == -1)
> >                         perror("poll");
> >                 else
> >                         fprintf(stderr, "timeout\n");
> > 
> >         }
> > }
> > 
> > int main(void)
> > {
> >         int fd;
> > 
> >         fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
> >         if (fd == -1) {
> >                 perror("open");
> >                 return 1;
> >         };
> >         loop(fd);
> >         close(fd);
> >         return 0;
> > }
> > 
> > This can be observed in the real word e.g. with nested qemu/KVM virtual
> > machines, if both the "outer" and "inner" VMs have a virtio-rng device.
> > If the "inner" VM requests random data, qemu running in the "outer" VM
> > uses this device in a non-blocking manner like the test program above.
> > 
> > Fix it by returning available data if a previous hypervisor call has
> > completed. I tested this patch with the program above, and with rng-tools.
> > 
> > v2 -> v3: Simplified the implementation as suggested by Laurent Vivier
> > 
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> >  drivers/char/hw_random/virtio-rng.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > index a90001e02bf7..8eaeceecb41e 100644
> > --- a/drivers/char/hw_random/virtio-rng.c
> > +++ b/drivers/char/hw_random/virtio-rng.c
> > @@ -65,7 +65,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >  		register_buffer(vi, buf, size);
> >  	}
> >  
> > -	if (!wait)
> > +	if (!wait && !completion_done(&vi->have_data))
> >  		return 0;
> >  
> >  	ret = wait_for_completion_killable(&vi->have_data);
> > @@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >  
> >  	vi->busy = false;
> >  
> > -	return vi->data_avail;
> > +	return min_t(size_t, size, vi->data_avail);
> >  }
> >  
> >  static void virtio_cleanup(struct hwrng *rng)
> > 
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Laurent didn't we agree the real fix is private buffers in the driver,
and copying out from there?

-- 
MST


