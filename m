Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA7DC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6686208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k141A5Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6686208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHTi-0003px-Mu
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHSP-000311-Lm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:22:22 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHSM-0000bi-TU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:22:21 -0400
Received: by mail-ed1-x542.google.com with SMTP id j2so6760378eds.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l9zJeE1NhhnAGrqEhGM8u6+63MpQQfWplPtINlwjK1g=;
 b=k141A5UoHu3Q7NKdx1e2TBFoSng5ujwaZEeHZl72xGnoWUZ/0xgpYPHumD+/cKnEsK
 4Mt+tvr1s8OIrT2YDIhvGm7LCO4KnvcUmrZCLvSju3zwlW7GhS8HFvmzqWLi3lXGYVGw
 eERpJ4b49SbXEyd0U54JNS4GZtJQjp7GqxoZSV7s1MVL2P4ZNZOwEm8JYsAUYDvJGLSM
 ybUJdvrj7H6VKDJmy142nuo1QLGVm3SYrkCWa/3fFZyLTkYfyKGFt5zfPDQJapeOx60w
 T2GG38FpzfR8NPJo9mmi0piUKyaVeVoLtRUf1Kf6anT8Sfm/Ad+UkA/Z4c4siLnlA2RF
 KDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l9zJeE1NhhnAGrqEhGM8u6+63MpQQfWplPtINlwjK1g=;
 b=BdyIIe/IQnLPe3LIuPaegfNvvT5gE3f1560t5wt21ShWQ5J/SnQG8L/vvJsP2pwKuK
 m60kmXp0HQNZubdO4GzAd+CYBq/TDCMGPWCFEBViraVGqGMY7mOAkqbEs2r7C96bnwFp
 AnPGHOyAKVVWgyRMmIJQw7cqQZhKqV/lw0FE48QcXw7sarqtRDGfgSy5WQxZ3Tm4MG61
 EgLaAaOfReRMqqBctCnXNrRpkfRO0v/0u+Xj/lXVkneXBglVPVwSIG7B8KGn6kGaTTi1
 HOVWAlS5CeZqLyP0hoVTAwQFLetZiUZcip/GyQt/3Hz3oCcLOBEwc82wMeooNUpGLrl8
 gEfA==
X-Gm-Message-State: AOAM5319w8qNrKlWiAsH28TWH/bryDvoapnvQCGBLkIiBOjMrZu6bcEM
 LJEEMWvJfelw5T8Wr7llH2Yl0RIYXKiSkNz6IkwMGzjPKwQ=
X-Google-Smtp-Source: ABdhPJzKvEUdLGHmXKeYqEOt7f51wyX9GvKlOeF+5VltVWztzZ1I6tmEfx2pMa0i371NLA/8BvE3YvwuGqX60bAPy38=
X-Received: by 2002:a50:fc08:: with SMTP id i8mr3949615edr.257.1601392936692; 
 Tue, 29 Sep 2020 08:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599470071.git.tgolembi@redhat.com>
 <d8573ee72572ba586c285472789243b37527e2b9.1599470071.git.tgolembi@redhat.com>
In-Reply-To: <d8573ee72572ba586c285472789243b37527e2b9.1599470071.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 19:22:04 +0400
Message-ID: <CAJ+F1CL_Ax=tPZu-nV=5xQAxVqYhZ+L7csvdTnE12F44egOcLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] qga: add command guest-get-disks
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000232e8e05b0755992"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000232e8e05b0755992
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2020 at 1:16 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com>
wrote:

> Add API and stubs for new guest-get-disks command.
>
> The command guest-get-fsinfo can be used to list information about disks
> and partitions but it is limited only to mounted disks with filesystem.
> This new command should allow listing information about disks of the VM
> regardles whether they are mounted or not. This can be usefull for
> management applications for mapping virtualized devices or pass-through
> devices to device names in the guest OS.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  qga/commands-posix.c |  6 ++++++
>  qga/commands-win32.c |  6 ++++++
>  qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 744c2b5a5d..f99731af51 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -3042,3 +3042,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>
>      return info;
>  }
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index aaa71f147b..e9976a0c46 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2229,3 +2229,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>
>      return info;
>  }
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 408a662ea5..70b54e0d07 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -862,6 +862,35 @@
>             'bus': 'int', 'target': 'int', 'unit': 'int',
>             '*serial': 'str', '*dev': 'str'} }
>
> +##
> +# @GuestDiskInfo:
> +#
> +# @name: device node (Linux) or device UNC (Windows)
> +# @partition: whether this is a partition or disk
> +# @slaves: list of slave devices (Linux)
> +# @address: disk address information (only for non-virtual devices)
> +# @alias: optional alias assigned to the disk, on Linux this is a name
> assigned
> +#         by device mapper
> +#
> +# Since 5.2
> +##
> +{ 'struct': 'GuestDiskInfo',
> +  'data': {'name': 'str', 'partition': 'bool', 'slaves': ['str'],
> +           '*address': 'GuestDiskAddress', '*alias': 'str'} }
> +
> +##
> +# @guest-get-disks:
> +#
> +# Returns: The list of disks in the guest. For Windows these are only th=
e
> +#          physical disks. On Linux these are all root block devices of
> +#          non-zero size including e.g. removable devices, loop devices,
> +#          NBD, etc.
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'guest-get-disks',
> +  'returns': ['GuestDiskInfo'] }
> +
>  ##
>  # @GuestFilesystemInfo:
>  #
> --
> 2.25.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000232e8e05b0755992
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2020 at 1:16 PM Tom=C3=
=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com" targ=
et=3D"_blank">tgolembi@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Add API and stubs for new guest-get-disks =
command.<br>
<br>
The command guest-get-fsinfo can be used to list information about disks<br=
>
and partitions but it is limited only to mounted disks with filesystem.<br>
This new command should allow listing information about disks of the VM<br>
regardles whether they are mounted or not. This can be usefull for<br>
management applications for mapping virtualized devices or pass-through<br>
devices to device names in the guest OS.<br>
<br>
Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgol=
embi@redhat.com" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br></blockqu=
ote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"=
mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redh=
at.com</a>&gt;=C2=A0 <br></div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
---<br>
=C2=A0qga/commands-posix.c |=C2=A0 6 ++++++<br>
=C2=A0qga/commands-win32.c |=C2=A0 6 ++++++<br>
=C2=A0qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++<br>
=C2=A03 files changed, 41 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 744c2b5a5d..f99731af51 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -3042,3 +3042,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return info;<br>
=C2=A0}<br>
+<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index aaa71f147b..e9976a0c46 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2229,3 +2229,9 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return info;<br>
=C2=A0}<br>
+<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 408a662ea5..70b54e0d07 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -862,6 +862,35 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;bus&#39;: &#39;int&#39;, &#3=
9;target&#39;: &#39;int&#39;, &#39;unit&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*serial&#39;: &#39;str&#39;,=
 &#39;*dev&#39;: &#39;str&#39;} }<br>
<br>
+##<br>
+# @GuestDiskInfo:<br>
+#<br>
+# @name: device node (Linux) or device UNC (Windows)<br>
+# @partition: whether this is a partition or disk<br>
+# @slaves: list of slave devices (Linux)<br>
+# @address: disk address information (only for non-virtual devices)<br>
+# @alias: optional alias assigned to the disk, on Linux this is a name ass=
igned<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0by device mapper<br>
+#<br>
+# Since 5.2<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestDiskInfo&#39;,<br>
+=C2=A0 &#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &#39;partition&#39;=
: &#39;bool&#39;, &#39;slaves&#39;: [&#39;str&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*address&#39;: &#39;GuestDis=
kAddress&#39;, &#39;*alias&#39;: &#39;str&#39;} }<br>
+<br>
+##<br>
+# @guest-get-disks:<br>
+#<br>
+# Returns: The list of disks in the guest. For Windows these are only the<=
br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 physical disks. On Linux these are all=
 root block devices of<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 non-zero size including e.g. removable=
 devices, loop devices,<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NBD, etc.<br>
+#<br>
+# Since: 5.2<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-get-disks&#39;,<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestDiskInfo&#39;] }<br>
+<br>
=C2=A0##<br>
=C2=A0# @GuestFilesystemInfo:<br>
=C2=A0#<br>
-- <br>
2.25.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=
=C3=A9 Lureau<br></div></div>

--000000000000232e8e05b0755992--

