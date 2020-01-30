Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365EB20661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwVlDzxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365EB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixD1M-0006Rj-CY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ixCwz-0002JZ-Hk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ixCwx-0004yN-1Q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:45:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29805
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ixCww-0004wQ-TV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580402750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RuWC1Qg4fuDemDfQjCzRM/ITUHbBIY6YOYOvueDwKI=;
 b=YwVlDzxU/09RTOOdmEWZu0su+8SFcZeOKaZY+O0CoBdzpVjOYfnAwG2ysHz0oW22J8u/aV
 ibN9MpKMj7VRPI8W2Is2XD9NmEH9bcnJXSDyRcmUCsyD/881ab68dv7zB4xfRET5hCyNTe
 rzK6a3yzOXryq7EGvKD2dIEbL6oXnfU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-ButFSASYNPKoLPqYi7DxCw-1; Thu, 30 Jan 2020 11:45:44 -0500
Received: by mail-wr1-f72.google.com with SMTP id z14so2007838wrs.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RFb/F1rIlR3s1JAOpdBILH5vR5LmaxCbbz+dXXa/5EI=;
 b=oSDBm9bS+xMBDRpy5Kfd5srXSUbmDFKdu+rv+4i+45L3q6DgavwbfarJEpIyjHQQYa
 Y8uIpOdYg9WDRQ2ewue9ZbDeXLSSvQwtTBoCeer9pBFPqkbsxhZ2XEDfRiSno9d7WLR8
 iD0OgDpFUtFe0IindOjUMq0muEf7nmGLBfihZWEdTFW3D2bcf0egDU51hozpK/0rc+iJ
 EoOSf8zprTtA/3fnadW7h+hSBSqbqWmlVwPGriE6C6FijL6y0sVFhvVBcm8Bp6olVTg/
 9Y+2tSv6ivos2VsCYuoqU6YvRCQKhxZJBe71IVGftpfRMkMUkExyVmLG2wEmqdjQYkPd
 gcKA==
X-Gm-Message-State: APjAAAVzn+GsTNoJAp4y8YuBiNA4Wul5Hun/0uSx4hptv3ljx3Ld/ogJ
 umHkhY9CK8iUpeiOiSU16lXc2g475gjDUkk02Z04dz8aPdGjQh175359fFB5GaHwp/RYKXKBLgI
 h95BCTQckMyPY4TY=
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr3384569wmf.176.1580402742931; 
 Thu, 30 Jan 2020 08:45:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEBMGOfmK2vOuZ7leSeK4bvlK3DZPAR7r/BWHNfggRyu3XozLjBnxI1XS8Up7nC1ahVUA3qw==
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr3384541wmf.176.1580402742659; 
 Thu, 30 Jan 2020 08:45:42 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id i2sm7263230wmb.28.2020.01.30.08.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:45:42 -0800 (PST)
Date: Thu, 30 Jan 2020 17:45:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 2/6] tests/boot_linux_console: add BIOS acceptance test
Message-ID: <20200130164539.d4je7djpxjak3qql@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-3-git-send-email-liam.merwick@oracle.com>
 <20200130112721.vm5u5zv7bifjremw@steredhat>
 <ce5b024f-8fd6-d325-a9f7-fbea4ffeff0f@oracle.com>
 <525a194e-131a-56e2-2870-e8709a214135@oracle.com>
MIME-Version: 1.0
In-Reply-To: <525a194e-131a-56e2-2870-e8709a214135@oracle.com>
X-MC-Unique: ButFSASYNPKoLPqYi7DxCw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: fam@euphon.net, slp@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 wainersm@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 04:28:52PM +0000, Liam Merwick wrote:
> On 30/01/2020 15:34, Liam Merwick wrote:
> > On 30/01/2020 11:27, Stefano Garzarella wrote:
> > > Hi Liam,
> > >=20
> > > On Mon, Jan 27, 2020 at 04:36:30PM +0000, Liam Merwick wrote:
> > > > Add tests to use qboot with the 'pc' and 'microvm' machine classes
> > > > by adding the '-bios' option via self.vm.add_args() before calling
> > > > do_test_x86_64_machine().
> > > >=20
> > > > Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> > > > ---
> > > > =A0 tests/acceptance/boot_linux_console.py | 15 ++++++++++++++-
> > > > =A0 1 file changed, 14 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/tests/acceptance/boot_linux_console.py
> > > > b/tests/acceptance/boot_linux_console.py
> > > > index aa5b07b1c609..8daf6461ffac 100644
> > > > --- a/tests/acceptance/boot_linux_console.py
> > > > +++ b/tests/acceptance/boot_linux_console.py
> >=20
> > ...
> >=20
> > > > +=A0=A0=A0 def test_x86_64_microvm_qboot(self):
> > > > +=A0=A0=A0=A0=A0=A0=A0 """
> > > > +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
> > > > +=A0=A0=A0=A0=A0=A0=A0 """
> > > > +=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-bios', 'pc-bios/bios-micr=
ovm.bin')
> > > > +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
> > > > +
> > >=20
> > > Reading the docs/microvm.rst, microvm should use qboot as default, so
> > > the test_x86_64_microvm() and test_x86_64_microvm_qboot() maybe are t=
he
> > > same (I didn't test them).
> >=20
> > I traced loader_write_rom() and in both cases bios-microvm.bin got
> > loaded. While there may be a slight benefit in verifying that usage of
> > an explicit -bios works, I think I'll just drop the unnecessary test
> > case in patches 2 and 6 in v2.
> >=20
>=20
> When making that change to remove the test case from Patch2, it dawned
> on me that it might be worth testing microvm with a different bios
> instead...

Make sense! In docs/microvm.rst we say we support both, so it seems
reasonable to test even seabios.

Thanks,
Stefano

>=20
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -87,6 +87,13 @@ class BootLinuxConsole(Test):
>          """
>          self.do_test_x86_64_machine()
>=20
> +    def test_x86_64_microvm_seabios(self):
> +        """
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios.bin')
> +        self.do_test_x86_64_machine()
> +


