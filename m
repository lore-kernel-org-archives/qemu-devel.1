Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F363EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF5F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il2aD5i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF5F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkhyb-0006Q0-2V
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 01:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jkhxn-00060Q-50
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 01:47:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jkhxl-0004yt-CU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 01:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592200036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaBONmNmIoZWkkuJR+FIqM7ZHZjVHg33TRh1HwPUlVM=;
 b=il2aD5i0JIpJEE4+7Bn7FFHl2B75Qzqnch2VQIwLy7t4L7la60pIUURrU9vU5AmW5d8LLq
 Q+Kg3eQeugxn8wCAUe0qOhjMLnbjTnf7ipvWOaZBnR+on4OWu5u3/mzPdnkjYdUxbq3qYi
 xuWMRG7dXXwmvreP2JjVjHgO4V+9mco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-gzZNINNDOu2yz-9mYeoqNQ-1; Mon, 15 Jun 2020 01:47:14 -0400
X-MC-Unique: gzZNINNDOu2yz-9mYeoqNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF81188360C
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 05:47:13 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 804827B91C;
 Mon, 15 Jun 2020 05:47:09 +0000 (UTC)
Subject: Re: [PATCH v8 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200609170727.9977-1-philmd@redhat.com>
 <20200609170727.9977-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7b3c2bba-27a9-5d66-8ee8-076802e78cde@redhat.com>
Date: Mon, 15 Jun 2020 07:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200609170727.9977-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/09/20 19:07, Philippe Mathieu-Daudé wrote:
> The 'gen_id' argument refers to a QOM object able to produce
> data consumable by the fw_cfg device. The producer object must
> implement the FW_CFG_DATA_GENERATOR interface.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v8: addressed Laszlo's comments
> - fixed 2-space indent
> - do not return 0 on failure
> ---
>  softmmu/vl.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 05d1a4cb6b..a9bce2a1b1 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -489,6 +489,11 @@ static QemuOptsList qemu_fw_cfg_opts = {
>              .name = "string",
>              .type = QEMU_OPT_STRING,
>              .help = "Sets content of the blob to be inserted from a string",
> +        }, {
> +            .name = "gen_id",
> +            .type = QEMU_OPT_STRING,
> +            .help = "Sets id of the object generating the fw_cfg blob "
> +                    "to be inserted",
>          },
>          { /* end of list */ }
>      },
> @@ -2020,7 +2025,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      gchar *buf;
>      size_t size;
> -    const char *name, *file, *str;
> +    const char *name, *file, *str, *gen_id;
>      FWCfgState *fw_cfg = (FWCfgState *) opaque;
>  
>      if (fw_cfg == NULL) {
> @@ -2030,14 +2035,13 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>      name = qemu_opt_get(opts, "name");
>      file = qemu_opt_get(opts, "file");
>      str = qemu_opt_get(opts, "string");
> +    gen_id = qemu_opt_get(opts, "gen_id");
>  
> -    /* we need name and either a file or the content string */
> -    if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)))) {
> -        error_setg(errp, "invalid argument(s)");
> -        return -1;
> -    }
> -    if (nonempty_str(file) && nonempty_str(str)) {
> -        error_setg(errp, "file and string are mutually exclusive");
> +    /* we need the name, and exactly one of: file, content string, gen_id */
> +    if (!nonempty_str(name) ||
> +        nonempty_str(file) + nonempty_str(str) + nonempty_str(gen_id) != 1) {
> +        error_setg(errp, "name, plus exactly one of file,"
> +                         " string and gen_id, are needed");
>          return -1;
>      }
>      if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
> @@ -2052,6 +2056,11 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>      if (nonempty_str(str)) {
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
> +    } else if (nonempty_str(gen_id)) {
> +        size_t fw_cfg_size;
> +
> +        fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
> +        return (fw_cfg_size > 0) ? 0 : -1;
>      } else {
>          GError *err = NULL;
>          if (!g_file_get_contents(file, &buf, &size, &err)) {
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


