Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F18C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EC42082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoUac+GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EC42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00yB-0003yD-PO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j00wo-0002co-0L
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j00wm-000561-Co
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j00wm-00054h-8C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZmViOsKu98hNwYbu5pf1Xx1y67S7uQlZEibCQwLIcs=;
 b=PoUac+GPYAc+2KUv9hi+rrWpeedYWVeq/ojoHn9frySAr0SwzHaXKnayJIq4n4PRCNAjFp
 Xk78mtV5jwpjDj7ff64l29MQSxiSUaGyZK2gkpjIYft7zBymlol4SuqKCfQOpgblYT88jb
 3P/yHEc4cVT+AUlODdGFzqM7O0hZqSs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-Am4vmwmzPMmKRYGmJNl2uA-1; Fri, 07 Feb 2020 05:33:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id y24so572701wmj.8
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 02:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wv7FxP5FXwlWJ1YQU7sMw01ngF59VRYUQE57484Ax38=;
 b=tmg3Uqs2D4195bVirWD9Qj6XLvGZ/jxHkwBF4vdg5jTYPly/gZ/QB4Iu7NUu0wNJ6w
 Lhvsq87T8KHe8Jc/Ki2K/2QM+zpXRZLD18LsY7klRpablzII0fbqYXqkQX0W69SO1EdL
 VfM60jbu2ariNeJV7xZrnfTxRZEyGb3ohr/h/woGRvIqIBMM8S2SIjAoYTafFwklRcAw
 fWdEw9gzwZVHYHMIj0MHIfMDyQoBF0yvKBRQrrb//usf/Fe67JLLQGDxRCv91ukMov8w
 vcJ/wShAq9ldSX6Gx5A8dCbtLdrjg/dUpMDWFS4ZlUSFmOF6arYxcu9X15zO2ef/YGF+
 zLYw==
X-Gm-Message-State: APjAAAWYRDB8UKVAfGJvA+2jYgsMko2QpURcI6dJMcmjkBspAFwacjUQ
 Vu+7TjO9/KoDhyY08AgrkErUISXSKlfecRAFLXHAJfqdmf42oPvwB632eim1gy3H5kPT5tLIvW3
 0BzGdk43/WuKrCQE=
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr3699411wmj.170.1581071590388; 
 Fri, 07 Feb 2020 02:33:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9QcQN6IWVxgE/uuTS56SygdGKQjCxNOfZGMDmmDtJPQYBseZdXVMoYS7EVXv6jn8gjw3czg==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr3699382wmj.170.1581071590092; 
 Fri, 07 Feb 2020 02:33:10 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o15sm2820806wra.83.2020.02.07.02.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 02:33:09 -0800 (PST)
Subject: Re: [PATCH 16/29] qapi/{block, misc, tmp}.json: Use explicit bulleted
 lists
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-17-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8994bdd6-1064-7d9a-0179-a8b8ef96f7cd@redhat.com>
Date: Fri, 7 Feb 2020 11:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206173040.17337-17-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: Am4vmwmzPMmKRYGmJNl2uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 6:30 PM, Peter Maydell wrote:
> A JSON block comment like this:
>       Returns: nothing on success
>                If @node is not a valid block device, DeviceNotFound
>                If @name is not found, GenericError with an explanation
>=20
> renders in the HTML and manpage like this:
>=20
>       Returns: nothing on success If node is not a valid block device,
>       DeviceNotFound If name is not found, GenericError with an explanati=
on
>=20
> because whitespace is not significant.
>=20
> Use an actual bulleted list, so that the formatting is correct.
>=20
> This commit gathers up the remaining json files which had
> places needing this fix.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   qapi/block.json | 33 ++++++++++++++-------------------
>   qapi/misc.json  | 36 ++++++++++++++++--------------------
>   qapi/tpm.json   |  4 ++--
>   3 files changed, 32 insertions(+), 41 deletions(-)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index 905297bab2e..e509cc53506 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -115,15 +115,12 @@
>   #
>   # For the arguments, see the documentation of BlockdevSnapshotInternal.
>   #
> -# Returns: nothing on success
> -#
> -#          If @device is not a valid block device, GenericError
> -#
> -#          If any snapshot matching @name exists, or @name is empty,
> -#          GenericError
> -#
> -#          If the format of the image used does not support it,
> -#          BlockFormatFeatureNotSupported
> +# Returns: - nothing on success
> +#          - If @device is not a valid block device, GenericError
> +#          - If any snapshot matching @name exists, or @name is empty,
> +#            GenericError
> +#          - If the format of the image used does not support it,
> +#            BlockFormatFeatureNotSupported
>   #
>   # Since: 1.7
>   #
> @@ -154,12 +151,12 @@
>   #
>   # @name: optional the snapshot's name to be deleted
>   #
> -# Returns: SnapshotInfo on success
> -#          If @device is not a valid block device, GenericError
> -#          If snapshot not found, GenericError
> -#          If the format of the image used does not support it,
> -#          BlockFormatFeatureNotSupported
> -#          If @id and @name are both not specified, GenericError
> +# Returns: - SnapshotInfo on success
> +#          - If @device is not a valid block device, GenericError
> +#          - If snapshot not found, GenericError
> +#          - If the format of the image used does not support it,
> +#            BlockFormatFeatureNotSupported
> +#          - If @id and @name are both not specified, GenericError
>   #
>   # Since: 1.7
>   #
> @@ -197,10 +194,8 @@
>   # @force: If true, eject regardless of whether the drive is locked.
>   #         If not specified, the default value is false.
>   #
> -# Returns:  Nothing on success
> -#
> -#           If @device is not a valid block device, DeviceNotFound
> -#
> +# Returns: - Nothing on success
> +#          - If @device is not a valid block device, DeviceNotFound
>   # Notes:    Ejecting a device with no media results in success
>   #
>   # Since: 0.14.0
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 626a342b008..06c80b58a24 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -418,12 +418,10 @@
>   #
>   # Return information about the balloon device.
>   #
> -# Returns: @BalloonInfo on success
> -#
> -#          If the balloon driver is enabled but not functional because t=
he KVM
> -#          kernel module cannot support it, KvmMissingCap
> -#
> -#          If no balloon device is present, DeviceNotActive
> +# Returns: - @BalloonInfo on success
> +#          - If the balloon driver is enabled but not functional because=
 the KVM
> +#            kernel module cannot support it, KvmMissingCap
> +#          - If no balloon device is present, DeviceNotActive
>   #
>   # Since: 0.14.0
>   #
> @@ -480,8 +478,8 @@
>   #
>   # @bar: the index of the Base Address Register for this region
>   #
> -# @type: 'io' if the region is a PIO region
> -#        'memory' if the region is a MMIO region
> +# @type: - 'io' if the region is a PIO region
> +#        - 'memory' if the region is a MMIO region
>   #
>   # @size: memory size
>   #
> @@ -992,10 +990,10 @@
>   #
>   # @value: the target size of the balloon in bytes
>   #
> -# Returns: Nothing on success
> -#          If the balloon driver is enabled but not functional because t=
he KVM
> +# Returns: - Nothing on success
> +#          - If the balloon driver is enabled but not functional because=
 the KVM
>   #            kernel module cannot support it, KvmMissingCap
> -#          If no balloon device is present, DeviceNotActive
> +#          - If no balloon device is present, DeviceNotActive
>   #
>   # Notes: This command just issues a request to the guest.  When it retu=
rns,
>   #        the balloon size may not have changed.  A guest can change the=
 balloon
> @@ -1074,8 +1072,8 @@
>   #       If @device is 'vnc' and @target is 'password', this is the new =
VNC
>   #       password to set.  See change-vnc-password for additional notes.
>   #
> -# Returns: Nothing on success.
> -#          If @device is not a valid block device, DeviceNotFound
> +# Returns: - Nothing on success.
> +#          - If @device is not a valid block device, DeviceNotFound
>   #
>   # Notes: This interface is deprecated, and it is strongly recommended t=
hat you
>   #        avoid using it.  For changing block devices, use
> @@ -1225,11 +1223,9 @@
>   #
>   # @opaque: A free-form string that can be used to describe the fd.
>   #
> -# Returns: @AddfdInfo on success
> -#
> -#          If file descriptor was not received, FdNotSupplied
> -#
> -#          If @fdset-id is a negative value, InvalidParameterValue
> +# Returns: - @AddfdInfo on success
> +#          - If file descriptor was not received, FdNotSupplied
> +#          - If @fdset-id is a negative value, InvalidParameterValue
>   #
>   # Notes: The list of fd sets is shared by all monitor connections.
>   #
> @@ -1257,8 +1253,8 @@
>   #
>   # @fd: The file descriptor that is to be removed.
>   #
> -# Returns: Nothing on success
> -#          If @fdset-id or @fd is not found, FdNotFound
> +# Returns: - Nothing on success
> +#          - If @fdset-id or @fd is not found, FdNotFound
>   #
>   # Since: 1.2.0
>   #
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 63878aa0f47..dc1f0817399 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -96,8 +96,8 @@
>   #
>   # A union referencing different TPM backend types' configuration option=
s
>   #
> -# @type: 'passthrough' The configuration options for the TPM passthrough=
 type
> -#        'emulator' The configuration options for TPM emulator backend t=
ype
> +# @type: - 'passthrough' The configuration options for the TPM passthrou=
gh type
> +#        - 'emulator' The configuration options for TPM emulator backend=
 type
>   #
>   # Since: 1.5
>   ##
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


