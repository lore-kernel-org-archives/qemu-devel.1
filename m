Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3584C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC762076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKb4/boO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC762076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5SR0-00058R-P0
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5SQB-0004PB-0C
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:26:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50696
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5SQ8-0006Ts-2Y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597145178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMyfeaWOAmGShheG4PrBuj4YCLetggwAwUSkL1meUIA=;
 b=jKb4/boOhcGP+35jk+i3ma+KqLfvwtIo+9jaTnZn1wQBs9LHhXzc8nqT69LLgifrgPlj/n
 HMgF6eidKnc/qdX5ZDnzPlbXiBSKCEk7v9XhuJNEng1uZ7l74Ga8cUbseBA4FtkYBdoPoo
 GXL3sNUNFHnv85ylnsyzdlrAPNUDQJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-xlR3MjwENyqjZmBUSTGf9A-1; Tue, 11 Aug 2020 07:26:17 -0400
X-MC-Unique: xlR3MjwENyqjZmBUSTGf9A-1
Received: by mail-wr1-f69.google.com with SMTP id z1so5479258wrn.18
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 04:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iMyfeaWOAmGShheG4PrBuj4YCLetggwAwUSkL1meUIA=;
 b=e5yDw/QkikZp9ku5NU4lXt9jVe61hW6i64hwX4htxGwCeS7p8cg//K5+xnyRia3J6U
 576W6rG0VetSSCxwovNHRZczeEus8IYsqZ8H5AdxTIqU8kfhNQmne6VlCF92g9pY8NbW
 feib2mRAoZtHZ3JtYyE01B0qlFPOmUlUwQbF3k7eoiqwKhWCAN72m9MHxfkh1/zPXQp7
 CxBO/F44Uxe6SLm2mjpjwZO+vxHHic7YW4gNGvHfJfdSL1/hIbmx0uW3NqArmxSt6W+N
 VNzLho4Mz3roz8SO5ebURxcnOH4azSVbmTpBZrTJ2Z/Q08b+wZTyYqbKhtkM5PhpxgNi
 lpxg==
X-Gm-Message-State: AOAM530U0NUqRLIV+D7CQzbl/WEOf0KLoBM5e3SKNQwD1hFZwZkmoBUc
 i0aV53jSX4C855l/Dxdf1acBqECULVBfn6c8jU/iS8yj/18oml2TUrVdY9vfhyFVWMQGwLv2UWW
 3/rP3602O4n1AAVY=
X-Received: by 2002:adf:ef08:: with SMTP id e8mr6046653wro.164.1597145174841; 
 Tue, 11 Aug 2020 04:26:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypnYkMPA7DMqq8CYhuKzDTIAa9ULJQxDDixSYC+mNmXEC6KzTA5hvyRBJb/IiWnr6gFfQg7g==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr6046629wro.164.1597145174565; 
 Tue, 11 Aug 2020 04:26:14 -0700 (PDT)
Received: from redhat.com ([147.161.8.240])
 by smtp.gmail.com with ESMTPSA id l10sm25455753wru.3.2020.08.11.04.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 04:26:13 -0700 (PDT)
Date: Tue, 11 Aug 2020 07:26:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: mwilck@suse.com
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811071726-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200715133255.10526-1-mwilck@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 03:32:55PM +0200, mwilck@suse.com wrote:
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
> completed in the meantime. I tested the patch with the program above,
> and with rng-tools.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 79a6e47b5fbc..984713b35892 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -59,6 +59,20 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  	if (vi->hwrng_removed)
>  		return -ENODEV;
>  
> +	/*
> +	 * If the previous call was non-blocking, we may have got some
> +	 * randomness already.
> +	 */
> +	if (vi->busy && completion_done(&vi->have_data)) {
> +		unsigned int len;
> +
> +		vi->busy = false;
> +		len = vi->data_avail > size ? size : vi->data_avail;
> +		vi->data_avail -= len;

I wonder what purpose does this line serve: busy is false
which basically means data_avail is invalid, right?
A following non blocking call will not enter here.

> +		if (len)
> +			return len;
> +	}
> +
>  	if (!vi->busy) {
>  		vi->busy = true;
>  		reinit_completion(&vi->have_data);

> -- 
> 2.26.2


