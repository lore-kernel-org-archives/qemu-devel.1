Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE45C2D0C8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAEB2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2AqFxnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAEB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMOz-0008P3-N8
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifMO6-0007qL-N3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifMO5-0006vW-Ip
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:12:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ifMO3-0006pC-2l; Thu, 12 Dec 2019 06:12:03 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so2297958wro.2;
 Thu, 12 Dec 2019 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WXFyVbyNIxYey72nOz7i5PjnqtQ0Kk6aT26c6M726rY=;
 b=T2AqFxnX/DmW084pAo8VntZ6XyE07V7rVdbMlqT5Gxfm5eFGpI/e/RuCRiPvW3gUD3
 CumkPlRErC8xid5UWcs+6EoOjPbyBQQFRGUSK1E8CLp5pbQoD8xE7cHAm6DEiRx1+2i4
 ieLu+nVxJaTD2Ex/olWig0S+7NqanQsYEOIZBpawurp+OQPseubWjTYh69nKwqQmJ1uz
 TfXGm4IVTEk9ELZlMNjbcjdSNIweIn80cz59dSPaGuZmi668iNz7rY35bjOTl173+ysu
 QOp8yX5egaagr2fQuZzM9Zwjt/Yh7TdAPYuJIqEDK47EfjAdjBuWh5YdhM8EYXvqbnAs
 FRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WXFyVbyNIxYey72nOz7i5PjnqtQ0Kk6aT26c6M726rY=;
 b=Iq/JNRiih3lzjFwhsRI+kTEq2H87mMRcRXIxeLrQHFUjQFm5G2RurDpk8B7Xuk77n9
 Jg529myEIAHmzZaM4etMyTmIZulKQSO6krDEh3Vc58V+juR7yRacWd0fE3DaLftuPcS3
 CxVx8utVCj854pHh8aTYpjWQadfZe++Z5xRRajtzcMBSioQC56SmYMFvaZ4DYAysvdb1
 hdhmwFRZR6h6sEPkCgE2z+SladSI3FDIuXB1oY588WuXJtigSysH8MrT5V/4SVr1CCRz
 7S9Q/Ou6/U9Y6aSETVpGztVp2hfGUDudoCAApQ3d3AgG3RUmyHzMp719JWHom+oo5XSn
 jZ8A==
X-Gm-Message-State: APjAAAU8Gx6E373AXXrPMcW1Y3kVAT07oDthKgyYbyDFOjXTtydtSDTv
 TZlOnms/dQNkGE0RW6xK0JmJxV3rt7UdXDO+i7I=
X-Google-Smtp-Source: APXvYqyIznXaB+/gsE08vHU9Lv5B7lLlQdtX3UTlgL0Lin59X8VdFZehw4yTqYhEPdNr+xTHqdqU/ootK8xulIWOQI8=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr5626891wrq.396.1576149121812; 
 Thu, 12 Dec 2019 03:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
 <20191211162050.970199-6-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20191211162050.970199-6-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Dec 2019 15:11:49 +0400
Message-ID: <CAJ+F1CJPZkkF5GsTH2+4gjP1h360KKZVDSx7CihAfW8WUJY5EQ@mail.gmail.com>
Subject: Re: [PACTH v3 5/5] docs: tpm: Add example command line for ppc64 and
 tpm-spapr
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Dec 11, 2019 at 8:25 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Add an example to the TPM docs for how to add a TPM SPAPR
> device model to a QEMU VM emulating a pSeries machine.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(I'll look at converting it to rst)

> ---
>  docs/specs/tpm.txt | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 9c8cca042d..9c3e67d8a7 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -34,6 +34,12 @@ The CRB interface makes a memory mapped IO region in t=
he area 0xfed40000 -
>  QEMU files related to TPM CRB interface:
>   - hw/tpm/tpm_crb.c
>
> +
> +pSeries (ppc64) machines offer a tpm-spapr device model.
> +
> +QEMU files related to the SPAPR interface:
> + - hw/tpm/tpm_spapr.c
> +
>  =3D fw_cfg interface =3D
>
>  The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
> @@ -281,7 +287,7 @@ swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>    --log level=3D20
>
>  Command line to start QEMU with the TPM emulator device communicating wi=
th
> -the swtpm:
> +the swtpm (x86):
>
>  qemu-system-x86_64 -display sdl -accel kvm \
>    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> @@ -289,6 +295,18 @@ qemu-system-x86_64 -display sdl -accel kvm \
>    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>    -device tpm-tis,tpmdev=3Dtpm0 test.img
>
> +In case a pSeries machine is emulated, use the following command line:
> +
> +qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
> +  -m 1024 -bios slof.bin -boot menu=3Don \
> +  -nodefaults -device VGA -device pci-ohci -device usb-kbd \
> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +  -device tpm-spapr,tpmdev=3Dtpm0 \
> +  -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
> +  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0 \
> +  -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
> +
>
>  In case SeaBIOS is used as firmware, it should show the TPM menu item
>  after entering the menu with 'ESC'.
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

