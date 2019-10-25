Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F38CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3FE2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5w9B0bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3FE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO79B-0002SQ-Mr
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 17:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iO78C-0008Jr-ED
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iO789-0004Jn-PV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:28:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iO787-0004Iy-Qj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572038896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4ILVHRZi1HFz0bjyQxiwWmNcW6X4167plTLfWVmX1A=;
 b=H5w9B0bC5lx8aJnwL/3hmO3FAEWmuHd+JZWcVt4GhdJ4Z/VcbWvCz5XBGaOBerCwjh/acq
 GQ68T44HyM0nLaZgQaXUvFE7P7GEJ3CnUWEG8zF1QSUqsZhz+WVI9SR2VNzc3psz8gruDp
 AXe2KRksB6n8sU8O5kwUQMCyRMmJJmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-F75pepwgPS6bflOq5yM1YA-1; Fri, 25 Oct 2019 17:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F37DD800D49;
 Fri, 25 Oct 2019 21:28:11 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-26.ams2.redhat.com
 [10.36.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D79A5C1B5;
 Fri, 25 Oct 2019 21:28:05 +0000 (UTC)
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, philmd@redhat.com, kraxel@redhat.com
References: <20191025165706.177653-1-dgilbert@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <37ac197c-f20e-dd05-ff6a-13a2171c7148@redhat.com>
Date: Fri, 25 Oct 2019 23:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191025165706.177653-1-dgilbert@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: F75pepwgPS6bflOq5yM1YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: liq3ea@gmail.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 18:57, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
> to only allow the range 0..65535; however both qemu and libvirt document
> the special value -1  to mean don't reboot.
> Allow it again.
>
> Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error chec=
king")
> RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378e..1a9ec44232 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
>
>      if (reboot_timeout) {
>          rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
> +
>          /* validate the input */
> -        if (rt_val < 0 || rt_val > 0xffff) {
> +        if (rt_val < -1 || rt_val > 0xffff) {
>              error_report("reboot timeout is invalid,"
> -                         "it should be a value between 0 and 65535");
> +                         "it should be a value between -1 and 65535");
>              exit(1);
>          }
>      }
>

Ouch.

Here's the prototype of qemu_opt_get_number():

> uint64_t qemu_opt_get_number(QemuOpts *opts, const char *name, uint64_t d=
efval);

So, when we call it, here's what we actually do:

        rt_val =3D (int64_t)qemu_opt_get_number(opts, "reboot-timeout", (ui=
nt64_t)-1);
                 ^^^^^^^^^                                            ^^^^^=
^^^^^

The conversion to uint64_t is fine.

The conversion to int64_t is not great:

> Otherwise, the new type is signed and the value cannot be represented
> in it; either the result is implementation-defined or an
> implementation-defined signal is raised.

I guess we're exploiting two's complement, as the implementation-defined
result. Not great. :)

Here's what I'd prefer:

> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378ee0..16413550a1da 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -237,7 +237,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>  static void fw_cfg_reboot(FWCfgState *s)
>  {
>      const char *reboot_timeout =3D NULL;
> -    int64_t rt_val =3D -1;
> +    uint64_t rt_val =3D -1;
>      uint32_t rt_le32;
>
>      /* get user configuration */
> @@ -248,9 +248,9 @@ static void fw_cfg_reboot(FWCfgState *s)
>      if (reboot_timeout) {
>          rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
>          /* validate the input */
> -        if (rt_val < 0 || rt_val > 0xffff) {
> +        if (rt_val > 0xffff && rt_val !=3D (uint64_t)-1) {
>              error_report("reboot timeout is invalid,"
> -                         "it should be a value between 0 and 65535");
> +                         "it should be a value between -1 and 65535");
>              exit(1);
>          }
>      }

(

The trick is that strtoull(), in

  qemu_opt_get_number()
    qemu_opt_get_number_helper()
      parse_option_number()
        qemu_strtou64()
          strtoull()

turns "-1" into (uint64_t)-1, which counts as a valid conversion, per
spec:

> If the subject sequence has the expected form and the value of /base/
> is zero, the sequence of characters starting with the first digit is
> interpreted as an integer constant according to the rules of 6.4.4.1.
> If the subject sequence has the expected form and the value of /base/
> is between 2 and 36, it is used as the base for conversion, ascribing
> to each letter its value as given above. If the subject sequence
> begins with a minus sign, the value resulting from the conversion is
> negated (in the return type). A pointer to the final string is stored
> in the object pointed to by /endptr/, provided that /endptr/ is not a
> null pointer.

)

I don't insist though; if Phil is OK with the posted patch, I won't try
to block it.

Thanks
Laszlo


