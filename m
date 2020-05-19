Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AFEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B369B205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj9eQUNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B369B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbApc-00014C-VP
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 18:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbAoU-0000Qw-9k
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:34:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbAoS-0003KS-Lr
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589927654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSQt5zrBXPb8MlRG1BSrSMsBUljxJd6PegZURfudjbg=;
 b=Tj9eQUNKQWgKlvO1PYQiZLV+rKrTRVpAzwWB+o8otF+7xurxIRJwGRs4uaOGFPv1A2YnjK
 UOa22r8JGqpg/aTXi8BW6sJWZIjk87vET9VmkFXiBObV3mzJnmbzyKFoWGW9d0vdIR0QYM
 OhrQsyR/7SWhwunTRHTPVkT2edsTs4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-SrIhMD-eO26U0JUSwEHXdg-1; Tue, 19 May 2020 18:34:13 -0400
X-MC-Unique: SrIhMD-eO26U0JUSwEHXdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A2301B18BC1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:34:12 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-149.ams2.redhat.com
 [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B28D65C1BB;
 Tue, 19 May 2020 22:34:07 +0000 (UTC)
Subject: Re: [PATCH v6 2/5] softmmu/vl: Let -fw_cfg option take a 'blob_id'
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ce1f0c80-f26b-40de-6d5b-2dc8f92fcfa2@redhat.com>
Date: Wed, 20 May 2020 00:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
> The 'blob_id' argument refers to a QOM object able to produce
> data consumable by the fw_cfg device. The producer object must
> implement the FW_CFG_DATA_GENERATOR interface.

OK, this answers my OBJECT_CHECK() question under patch #1 (in the
negative -- an assert would be wrong).

>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  softmmu/vl.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ae5451bc23..f76c53ad2e 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -489,6 +489,10 @@ static QemuOptsList qemu_fw_cfg_opts = {
>              .name = "string",
>              .type = QEMU_OPT_STRING,
>              .help = "Sets content of the blob to be inserted from a string",
> +        }, {
> +            .name = "blob_id",
> +            .type = QEMU_OPT_STRING,
> +            .help = "Sets id of the object generating fw_cfg blob to be used",
>          },
>          { /* end of list */ }
>      },
> @@ -2020,7 +2024,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      gchar *buf;
>      size_t size;
> -    const char *name, *file, *str;
> +    const char *name, *file, *str, *blob_id;
>      FWCfgState *fw_cfg = (FWCfgState *) opaque;
>
>      if (fw_cfg == NULL) {
> @@ -2030,14 +2034,17 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>      name = qemu_opt_get(opts, "name");
>      file = qemu_opt_get(opts, "file");
>      str = qemu_opt_get(opts, "string");
> +    blob_id = qemu_opt_get(opts, "blob_id");
>
>      /* we need name and either a file or the content string */

(1) Please update this comment. If the option is given, we need the
name, and exactly one of: file, content string, blob_id.

> -    if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)))) {
> +    if (!(nonempty_str(name)
> +          && (nonempty_str(file) || nonempty_str(str) || nonempty_str(blob_id)))
> +         ) {
>          error_setg(errp, "invalid argument(s)");
>          return -1;
>      }

(2) Coding style: does QEMU keep operators on the left or on the right
when breaking subconditions to new lines? (I vaguely recall "to the
right", but I could be wrong... Well, "hw/nvram/fw_cfg.c" has at least 7
examples of the operator being on the right.)

> -    if (nonempty_str(file) && nonempty_str(str)) {
> -        error_setg(errp, "file and string are mutually exclusive");
> +    if (nonempty_str(file) && nonempty_str(str) && nonempty_str(blob_id)) {
> +        error_setg(errp, "file, string and blob_id are mutually exclusive");
>          return -1;
>      }

(3) I believe this catches only when all three of name/string/blob_id
are given. But we should continue catching "two given".

How about reworking both "if"s, *and* the comment at (1) at the same
time, into:

    if (!nonempty_str(name) ||
        nonempty_str(file) + nonempty_str(str) + nonempty_str(blob_id) != 1) {
        error_setg(errp, "name, plus exactly one of file, string and blob_id, "
                   "are needed");
        return -1;
    }

(Regarding the addition, nonempty_str() returns a "bool", which is a
macro to _Bool, which is promoted to "int" or "unsigned int".)

>      if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
> @@ -2052,6 +2059,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>      if (nonempty_str(str)) {
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
> +    } else if (nonempty_str(blob_id)) {
> +        return fw_cfg_add_from_generator(fw_cfg, name, blob_id, errp);
>      } else {
>          GError *err = NULL;
>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>

(4) The "-fw_cfg" command line option is documented in both the qemu(1)
manual, and the "docs/specs/fw_cfg.txt" file.

I think we may have to update those. In particular I mean *where* the
option is documented (in both texts).

In the manual, "-fw_cfg" is currently under "Debug/Expert options", but
that will no longer apply (I think?) after this series.

Similarly, in "docs/specs/fw_cfg.txt", the section is called "Externally
Provided Items" -- but that might not be strictly true any more either.

Maybe leave the current "-fw_cfg" mentions in peace, and document
"-fw_cfg blob_id=..." separately (in different docs sections)? The
"fw_cfg generators" concept could deserve dedicated sections.

Sorry that I can't make a good concrete suggestion. :(

Thanks,
Laszlo


