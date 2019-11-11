Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE09FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980FF215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5Z3DGn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980FF215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6T2-0004n6-Kq
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 04:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iU6SN-0004ID-Mu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iU6SM-0003aa-FO
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:57:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iU6SM-0003aK-Bq
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573466277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LnLc6n1DacsMH9h3xyP+DJ6OR80TLvJhr8mExoEonE=;
 b=f5Z3DGn6KHjbsOQmG/FxOwsRql4b0q9s1+5qheuS/yR7NMtubjDpY9cqtXlM6oP8xpxVK2
 HODduV1QiRVtDY/vU3GBjhUelm70H1u8J7fCY31hFxbrEmYTR5R3YxrJSj/S+J97jk1kbV
 T3XxEw+5XygIRpo/O6Su4dKp0imI8nc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-eBZTFYnlNSSMlE1zoyinNg-1; Mon, 11 Nov 2019 04:57:54 -0500
Received: by mail-wm1-f71.google.com with SMTP id y133so5928138wmd.8
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 01:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1QIu26PlBIMBaZ9ertttxX4zkB9Vu05BPbb+lmR/ztA=;
 b=RIiS3Tb/HAouQqdr3DFqFOQw1PtAOiVCm1jvmE32akjDYJgYg+9IlHvM1QhL6cVEdw
 0DPdH8OxrVwRB8RTWH+wn+k8bcpA2VhaDf9dFNOCOx2kpKENGwkc6VHcW6LQCy4MTsFx
 Bav1rDcetZPNuAfFdRpYQIdcRfWA/6Jt65fj65+VtVIQi21URt+2eSUX3m603MGg/F9G
 XVwY93oGuvAPvaw7HIS5VIVt6wcwBA+2RswgwcyYNTGUHWirorSdIJfO9yRipmM3p8aW
 NiC2w6GAIwbuJmxh0ZvYAcpmIg99qJwDzWzAr2EJLRxlI7eczLuQ2R/0rVcMNqRjbSGo
 keXw==
X-Gm-Message-State: APjAAAVUIugZPLh5KYz+0o/0VDQ5kd+qK4ur+kwKaGcGJdMOvrIHYXWt
 8klVuyYDM/Xl/DpIMDk+dVFzEvb5FvFv9ApLKUKCrmyCZhMCvYUGEwSO67SdxcjD/HeigXXjiC2
 sbnHqCpkqvXTD7Zk=
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr20875836wmj.127.1573466273276; 
 Mon, 11 Nov 2019 01:57:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpgZv/ZC0Jm31+bfS3f42HYiQqfMLeFXFu8L2ip8uDLfEeAhyuiFffD7cND45hxn5Bolvifg==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr20875801wmj.127.1573466272936; 
 Mon, 11 Nov 2019 01:57:52 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
 by smtp.gmail.com with ESMTPSA id x7sm40090920wrg.63.2019.11.11.01.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 01:57:52 -0800 (PST)
Date: Mon, 11 Nov 2019 10:57:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/2] tests/tcg/multiarch: fix code style in function main
 of test-mmap.c
Message-ID: <20191111095749.m7s2bfxmx636f3qo@steredhat>
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
 <20191015031350.4345-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191015031350.4345-2-richardw.yang@linux.intel.com>
X-MC-Unique: eBZTFYnlNSSMlE1zoyinNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 jasowang@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 11:13:49AM +0800, Wei Yang wrote:
> This file uses quite a different code style and changing just one line
> would leads to some awkward appearance.
>=20
> This is a preparation for the following replacement of
> sysconf(_SC_PAGESIZE).
>=20
> BTW, to depress ERROR message from checkpatch.pl, this patch replaces
> strtoul with qemu_strtoul.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 31 deletions(-)
>=20
> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-m=
map.c
> index 11d0e777b1..9ea49e2307 100644
> --- a/tests/tcg/multiarch/test-mmap.c
> +++ b/tests/tcg/multiarch/test-mmap.c
> @@ -456,49 +456,54 @@ void check_invalid_mmaps(void)
> =20
>  int main(int argc, char **argv)
>  {
> -=09char tempname[] =3D "/tmp/.cmmapXXXXXX";
> -=09unsigned int i;
> -
> -=09/* Trust the first argument, otherwise probe the system for our
> -=09   pagesize.  */
> -=09if (argc > 1)
> -=09=09pagesize =3D strtoul(argv[1], NULL, 0);
> -=09else
> -=09=09pagesize =3D sysconf(_SC_PAGESIZE);
> +    char tempname[] =3D "/tmp/.cmmapXXXXXX";
> +    unsigned int i;
> +
> +    /*
> +     * Trust the first argument, otherwise probe the system for our
> +     * pagesize.
> +     */
> +    if (argc > 1) {
> +        qemu_strtoul(argv[1], NULL, 0, &pagesize);

What do you think about doing this change in a separate patch?

> +    } else {
> +        pagesize =3D sysconf(_SC_PAGESIZE);
> +    }
> =20
> -=09/* Assume pagesize is a power of two.  */
> -=09pagemask =3D pagesize - 1;
> -=09dummybuf =3D malloc (pagesize);
> -=09printf ("pagesize=3D%u pagemask=3D%x\n", pagesize, pagemask);
> +    /* Assume pagesize is a power of two.  */
> +    pagemask =3D pagesize - 1;
> +    dummybuf =3D malloc(pagesize);
> +    printf("pagesize=3D%u pagemask=3D%x\n", pagesize, pagemask);
> =20
> -=09test_fd =3D mkstemp(tempname);
> -=09unlink(tempname);
> +    test_fd =3D mkstemp(tempname);
> +    unlink(tempname);
> =20
> -=09/* Fill the file with int's counting from zero and up.  */
> +    /* Fill the file with int's counting from zero and up.  */
>      for (i =3D 0; i < (pagesize * 4) / sizeof i; i++) {
>          checked_write(test_fd, &i, sizeof i);
>      }
> =20
> -=09/* Append a few extra writes to make the file end at non=20
> -=09   page boundary.  */
> +    /*
> +     * Append a few extra writes to make the file end at non
> +     * page boundary.
> +     */
>      checked_write(test_fd, &i, sizeof i); i++;
>      checked_write(test_fd, &i, sizeof i); i++;
>      checked_write(test_fd, &i, sizeof i); i++;
> =20
> -=09test_fsize =3D lseek(test_fd, 0, SEEK_CUR);
> +    test_fsize =3D lseek(test_fd, 0, SEEK_CUR);
> =20
> -=09/* Run the tests.  */
> -=09check_aligned_anonymous_unfixed_mmaps();
> -=09check_aligned_anonymous_unfixed_colliding_mmaps();
> -=09check_aligned_anonymous_fixed_mmaps();
> -=09check_file_unfixed_mmaps();
> -=09check_file_fixed_mmaps();
> -=09check_file_fixed_eof_mmaps();
> -=09check_file_unfixed_eof_mmaps();
> -=09check_invalid_mmaps();
> +    /* Run the tests.  */
> +    check_aligned_anonymous_unfixed_mmaps();
> +    check_aligned_anonymous_unfixed_colliding_mmaps();
> +    check_aligned_anonymous_fixed_mmaps();
> +    check_file_unfixed_mmaps();
> +    check_file_fixed_mmaps();
> +    check_file_fixed_eof_mmaps();
> +    check_file_unfixed_eof_mmaps();
> +    check_invalid_mmaps();
> =20
> -=09/* Fails at the moment.  */
> -=09/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
> +    /* Fails at the moment.  */
> +    /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
> =20
> -=09return EXIT_SUCCESS;
> +    return EXIT_SUCCESS;
>  }

The rest looks good to me.

Thanks,
Stefano


