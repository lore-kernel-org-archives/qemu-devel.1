Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79168C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4309F207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/cFW5nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4309F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jka-0001b2-Fe
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4jjz-0001CN-4y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4jjx-0005uL-7J
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:11:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4jjw-0005tI-Pm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582197091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iN9yMkl453vUC5uXwwzBYucBmy930K7pQuO2ququVus=;
 b=H/cFW5nJU0uqZcPqyCeULAXffb5d3YjFuZ80IyAkFI4wbftX3sLABWj6MN0qHrz52rW03B
 3aCQDhf7XBlSb+E893MVTedkNK27afDa1jz/PlP5geDW1nnCYsUguejSnCLkagbma9DIWT
 MdVRECsefF8jSBV8xKzOl3uNq20r5h8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-kMFmEotVMqm4IFRGA4cWlg-1; Thu, 20 Feb 2020 06:11:30 -0500
Received: by mail-wr1-f71.google.com with SMTP id j4so1582865wrs.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 03:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=76obfnyun1m+2vpcQ4d0f0HvziPEKA5ReJZWMaJiqlA=;
 b=iBRWerTJkE9kcHddyGbyIfxNll9nGGVmh5Qhw6Nrg6r8wqPerObOvpZvHeIOfs1LHd
 ZHQl6YwYPMgQrkjOW0vU9pOW8Ue1RUTzab1LIdcWYQCF89rqTdzTBoH55NHqCBEMDjf0
 FTeH25oHwgu9AxUnuVQbzNNUmZl0MrTLt1P9M9k5AQN/CFeXl5XynmXDwcgkDSgi7qSJ
 +vsPpmS+3+kpWPpVlJZmFPEBxbNtZnD/k3WzlyGxoZxGkfZPjzAYKlPdzO6TcsYZgDyR
 NqOcC6nTGW4WvWmW8j+R47px6tQsODzsS0RUaIYIwmaY8i5/nm5q3S+RfDEYA4vhhXrX
 fxWg==
X-Gm-Message-State: APjAAAXl2hYztD54znNSrWaVrkd/kwJsUacUFxElaxdudF0Ppij24rsH
 ta48NmZb5XacE3P4buDNjvwY1cPIkJunMuh4wMdtadjLOJQlFGhIG2dBJDMf/Haj7uZrd0cqzAW
 TKckffXQlog6EFyo=
X-Received: by 2002:a7b:c759:: with SMTP id w25mr3811147wmk.15.1582197088605; 
 Thu, 20 Feb 2020 03:11:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvKkwcbeSFH8t18nqcIGzP4TiP3jqMyMVYGZdc71hdr4E6G8aRj86yIxwUc2I7EVMwfCnrZg==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr3811121wmk.15.1582197088299; 
 Thu, 20 Feb 2020 03:11:28 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id a184sm4069822wmf.29.2020.02.20.03.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 03:11:27 -0800 (PST)
Subject: Re: Requesting review about optimizing large guest start up time
To: =?UTF-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <e9dfa1311de74824983e769ea197c2e6@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54f9320a-77ad-90e6-a98d-b28847e4e54d@redhat.com>
Date: Thu, 20 Feb 2020 12:11:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e9dfa1311de74824983e769ea197c2e6@tencent.com>
Content-Language: en-US
X-MC-Unique: kMFmEotVMqm4IFRGA4cWlg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I queued the patch, thanks!

I simplified a bit the computation of the number of pages per thread, like =
this:

    numpages_per_thread =3D numpages / memset_num_threads;
    leftover =3D numpages % memset_num_threads;
    for (i =3D 0; i < memset_num_threads; i++) {
        memset_thread[i].addr =3D addr;
        memset_thread[i].numpages =3D numpages_per_thread + (i < leftover);
        memset_thread[i].hpagesize =3D hpagesize;
        ...

This removes the need for a separate array and function.

Thanks,

Paolo

On 11/02/20 13:08, bauerchen(=E9=99=88=E8=92=99=E8=92=99) wrote:
> From c882b155466313fcd85ac330a45a573e608b0d74 Mon Sep 17 00:00:00 2001
> From: bauerchen <bauerchen@tencent.com>
> Date: Tue, 11 Feb 2020 17:10:35 +0800
> Subject: [PATCH] Optimize: large guest start-up in mem-prealloc
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>=20
> [desc]:
> =C2=A0 =C2=A0 Large memory VM starts slowly when using -mem-prealloc, and
> =C2=A0 =C2=A0 there are some areas to optimize in current method;
>=20
> =C2=A0 =C2=A0 1=E3=80=81mmap will be used to alloc threads stack during c=
reate page
> =C2=A0 =C2=A0 clearing threads, and it will attempt mm->mmap_sem for writ=
e
> =C2=A0 =C2=A0 lock, but clearing threads have hold read lock, this compet=
ition
> =C2=A0 =C2=A0 will cause threads createion very slow;
>=20
> =C2=A0 =C2=A0 2=E3=80=81methods of calcuating pages for per threads is no=
t well;if we use
> =C2=A0 =C2=A0 64 threads to split 160 hugepage,63 threads clear 2page,1 t=
hread
> =C2=A0 =C2=A0 clear 34 page,so the entire speed is very slow;
>=20
> =C2=A0 =C2=A0 to solve the first problem,we add a mutex in thread functio=
n,and
> =C2=A0 =C2=A0 start all threads when all threads finished createion;
> =C2=A0 =C2=A0 and the second problem, we spread remainder to other thread=
s,in
> =C2=A0 =C2=A0 situation that 160 hugepage and 64 threads, there are 32 th=
reads
> =C2=A0 =C2=A0 clear 3 pages,and 32 threads clear 2 pages;
> [test]:
> =C2=A0 =C2=A0 320G 84c VM start time can be reduced to 10s
> =C2=A0 =C2=A0 680G 84c VM start time can be reduced to 18s
>=20
> Signed-off-by: bauerchen <bauerchen@tencent.com>
> Reviewed-by:Pan Rui <ruippan@tencent.com>
> Reviewed-by:Ivan Ren <ivanren@tencent.com>
> ---
> =C2=A0util/oslib-posix.c | 44 ++++++++++++++++++++++++++++++++++++-------=
-
> =C2=A01 file changed, 36 insertions(+), 8 deletions(-)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 5a291cc..e97369b 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -76,6 +76,10 @@ static MemsetThread *memset_thread;
> =C2=A0static int memset_num_threads;
> =C2=A0static bool memset_thread_failed;
> =C2=A0
> +static QemuMutex page_mutex;
> +static QemuCond page_cond;
> +static volatile bool thread_create_flag;
> +
> =C2=A0int qemu_get_thread_id(void)
> =C2=A0{
> =C2=A0#if defined(__linux__)
> @@ -403,6 +407,14 @@ static void *do_touch_pages(void *arg)
> =C2=A0 =C2=A0 =C2=A0MemsetThread *memset_args =3D (MemsetThread *)arg;
> =C2=A0 =C2=A0 =C2=A0sigset_t set, oldset;
> =C2=A0
> + =C2=A0 =C2=A0/*wait for all threads create finished */
> + =C2=A0 =C2=A0qemu_mutex_lock(&page_mutex);
> + =C2=A0 =C2=A0while(!thread_create_flag){
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_cond_wait(&page_cond, &page_mutex);
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0qemu_mutex_unlock(&page_mutex);
> +
> +
> =C2=A0 =C2=A0 =C2=A0/* unblock SIGBUS */
> =C2=A0 =C2=A0 =C2=A0sigemptyset(&set);
> =C2=A0 =C2=A0 =C2=A0sigaddset(&set, SIGBUS);
> @@ -448,30 +460,46 @@ static inline int get_memset_num_threads(int smp_cp=
us)
> =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> =C2=A0
> +static void calc_page_per_thread(size_t numpages, int memset_threads, si=
ze_t *pages_per_thread){
> + =C2=A0 =C2=A0int avg =3D numpages / memset_threads + 1;
> + =C2=A0 =C2=A0int i =3D 0;
> + =C2=A0 =C2=A0int last =3D avg * memset_threads - numpages;
> + =C2=A0 =C2=A0for (i =3D 0; i < memset_threads; i++)
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if(memset_threads - i <=3D last){
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages_per_thread[i] =3D avg - =
1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages_per_thread[i] =3D avg;
> + =C2=A0 =C2=A0}
> +}
> +
> =C2=A0static bool touch_all_pages(char *area, size_t hpagesize, size_t nu=
mpages,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int smp_cpus)
> =C2=A0{
> - =C2=A0 =C2=A0size_t numpages_per_thread;
> - =C2=A0 =C2=A0size_t size_per_thread;
> + =C2=A0 =C2=A0size_t *numpages_per_thread;
> =C2=A0 =C2=A0 =C2=A0char *addr =3D area;
> =C2=A0 =C2=A0 =C2=A0int i =3D 0;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0memset_thread_failed =3D false;
> + =C2=A0 =C2=A0thread_create_flag =3D false;
> =C2=A0 =C2=A0 =C2=A0memset_num_threads =3D get_memset_num_threads(smp_cpu=
s);
> + =C2=A0 =C2=A0numpages_per_thread =3D g_new0(size_t, memset_num_threads)=
;
> =C2=A0 =C2=A0 =C2=A0memset_thread =3D g_new0(MemsetThread, memset_num_thr=
eads);
> - =C2=A0 =C2=A0numpages_per_thread =3D (numpages / memset_num_threads);
> - =C2=A0 =C2=A0size_per_thread =3D (hpagesize * numpages_per_thread);
> + =C2=A0 =C2=A0calc_page_per_thread(numpages, memset_num_threads, numpage=
s_per_thread);
> +
> =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < memset_num_threads; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset_thread[i].addr =3D addr;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0memset_thread[i].numpages =3D (i =3D=3D (mem=
set_num_threads - 1)) ?
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0numpages : numpages_=
per_thread;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0memset_thread[i].numpages =3D numpages_per_t=
hread[i];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset_thread[i].hpagesize =3D hpagesiz=
e;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_create(&memset_thread[i].pg=
thread, "touch_pages",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 do_touch_pages, &memset_thread[i],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 QEMU_THREAD_JOINABLE);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D size_per_thread;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0numpages -=3D numpages_per_thread;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D numpages_per_thread[i] * hpagesize=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0numpages -=3D numpages_per_thread[i];
> =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0thread_create_flag =3D true;
> + =C2=A0 =C2=A0qemu_cond_broadcast(&page_cond);
> +
> =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < memset_num_threads; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_join(&memset_thread[i].pgth=
read);
> =C2=A0 =C2=A0 =C2=A0}
> --=C2=A0
> 1.8.3.1
>=20


