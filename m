Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF703C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DE52065C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnY89DG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DE52065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Rfv-0003U0-R0
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 06:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5RfD-00033n-Nu
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:37:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5RfA-0000cb-Ez
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597142266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U9LHxiGiYNMMkHt4E6XQc+T4RGD+JrB0IYZz0uIZK1Q=;
 b=gnY89DG5x+4hA5MKPvR1yGf3c3hXiF0uActxOsQoEe3wyl9LfmdRfPqoDLDjKWZYzJ7nUk
 GqlZaUrhFL7Y/B6973IsUZWoGy+hP1yhB/nvGmp+UD87PStYbdNwKlCqMQGqZu3vGX/3bH
 U8kOste282BDF0AcaeJGGiyZq2TeMNU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-YMwcPG85Mz2CEhrEGoBOaA-1; Tue, 11 Aug 2020 06:37:44 -0400
X-MC-Unique: YMwcPG85Mz2CEhrEGoBOaA-1
Received: by mail-wr1-f70.google.com with SMTP id 5so5404054wrc.17
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 03:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=U9LHxiGiYNMMkHt4E6XQc+T4RGD+JrB0IYZz0uIZK1Q=;
 b=MYogBM7Qy1RRgutURb1ZVJNwdTLG7L2OxzUjIzDCAhRTUe06MigPitLGEAfzNj8Uxe
 PtDTOkToH7eeLXERFH7cVH0Lr4qvMvgucbU4taqhWuhgVdxg72Qi01w3vjJ3a4bAlgaV
 OVMNQZXUAE27r2mGtyHIdQCj/xhTyYstV40XSofu+wfYVjLaGZ6fqkfS72kSTcmt3zzQ
 snYqxuAr1qj3iHscAB6fVqnEDtGwCACnT+ciQQY99IOJomgofxNIQ5ma2QN7jaupRB41
 sAKl6Td8F34rMLYWZu87K3yX9ofWrKIutS2agwBNmBAsG6itEy2yo0plpKtB1yeOqzgf
 GoOA==
X-Gm-Message-State: AOAM532h2TWIMLc3MFdQLPprlM1pU56mEhK82r/6GY2VvjexKX486lkA
 hZJpkFTeFU0te/MB++qceUcxMhXqpcj3pFG4YCqnKWuPLEG4Vg3u+7H7wocIpxBP+fgiOVjZNwI
 kM9yoU9b+I7sIdn8=
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr6021138wrw.363.1597142262956; 
 Tue, 11 Aug 2020 03:37:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC1votEDYLnMZ762YbmvJswtwiiTYwSHW0UP++yJsl+I8ZqI0kT533s40/TMWcwSGaKc+2ng==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr6021104wrw.363.1597142262578; 
 Tue, 11 Aug 2020 03:37:42 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s20sm4250116wmh.21.2020.08.11.03.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 03:37:41 -0700 (PDT)
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
To: mwilck@suse.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20200715133255.10526-1-mwilck@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
Date: Tue, 11 Aug 2020 12:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200715133255.10526-1-mwilck@suse.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
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
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You Cc'ed qemu-devel, so Cc'ing the virtio-rng maintainers.

On 7/15/20 3:32 PM, mwilck@suse.com wrote:
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
> +		if (len)
> +			return len;
> +	}
> +
>  	if (!vi->busy) {
>  		vi->busy = true;
>  		reinit_completion(&vi->have_data);
> 


