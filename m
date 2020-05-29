Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD09C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F5020776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGDBgHh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F5020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jebg7-0000uy-Jd
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jebeu-0000J4-Go
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:50:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jebet-00053E-0Z
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590745833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zStkw5ExJGFNvLMbc+vIpYYonaA9qNEItzqPGmrxPr8=;
 b=CGDBgHh57T3zsT4AopcRn/685/cHCBNT5lU9NLFyfn1xzsmqxt68dVY5+FB6BzWO4p4yVT
 MnK9L4J6LoJClathsLydm+xz0EWp3Oq7kOie2BVy/RVpjqy65FliJfmzA44DqhJApypv2y
 kkeF0OrufjkRYR31rQfh2UhtpOmYMi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-KtYZogPEOuurPO_1E5nIaA-1; Fri, 29 May 2020 05:50:30 -0400
X-MC-Unique: KtYZogPEOuurPO_1E5nIaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF964108BD18;
 Fri, 29 May 2020 09:50:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A696910013C2;
 Fri, 29 May 2020 09:50:25 +0000 (UTC)
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Corey Minyard <minyard@acm.org>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
Date: Fri, 29 May 2020 11:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528173141.17495-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd, Corey: there's a question for you near the end, please.

On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> The 'gen_id' argument refers to a QOM object able to produce
> data consumable by the fw_cfg device. The producer object must
> implement the FW_CFG_DATA_GENERATOR interface.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v7:
> - renamed 'blob_id' -> 'gen_id' (danpb)
> - update comment in code (lersek)
> - fixed CODING_STYLE (lersek)
> - use Laszlo's if (SUM(options)) != 1 { error } form
> ---
>  softmmu/vl.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ae5451bc23..cdb1d187ed 100644
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
> +          nonempty_str(file) + nonempty_str(str) + nonempty_str(gen_id) != 1) {

(1) I believe the indentation of this line is not correct. I think it
should be out-dented by 2 spaces.

> +        error_setg(errp, "name, plus exactly one of file,"
> +                         " string and gen_id, are needed");
>          return -1;
>      }
>      if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
> @@ -2052,6 +2056,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>      if (nonempty_str(str)) {
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
> +    } else if (nonempty_str(gen_id)) {
> +        return fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);

(2) This is no longer correct: fw_cfg_add_from_generator() now returns 0
on failure, but parse_fw_cfg() is supposed to return nonzer on failure.
See the comment on qemu_opts_foreach() -- "parse_fw_cfg" is passed as
the loop callback to qemu_opts_foreach().

Technically, we could simply write

        return !fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);

but that wouldn't be consistent with the -1 error codes returned
elsewhere from parse_fw_cfg(). So how about:

        size_t fw_cfg_size;

        fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
        return (fw_cfg_size > 0) ? 0 : -1;

I think your testing may have missed this because the problem is only
visible if you have *another* -fw_cfg option on the QEMU command line.
Returning the wrong status code from here terminates the
qemu_opts_foreach() loop, without attempting to set "error_fatal".
Therefore the loop is silently terminated, thus the only symptom would
be that -fw_cfg options beyond the "gen_id" one wouldn't take effect.


(3) I've noticed another *potential* issue, from looking at the larger
context. I apologize for missing it in v6.

See commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07). (I'm
copying Corey; Gerd is already copied.) From that commit, we have, at
the end of this function:

    /* For legacy, keep user files in a specific global order. */
    fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
    fw_cfg_add_file(fw_cfg, name, buf, size);
    fw_cfg_reset_order_override(fw_cfg);

This takes effect for "file" and "string", but not for "gen_id". Should
we apply it to "gen_id" as well? (Sorry, I really don't understand what
commit bab47d9a75a3 is about!)

*IF* we want to apply the same logic to "gen_id", then we should
*perhaps* do, on the "nonempty_str(gen_id)" branch:

        size_t fw_cfg_size;

        fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
        fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
        fw_cfg_reset_order_override(fw_cfg);
        return (fw_cfg_size > 0) ? 0 : -1;

I think???

Or maybe even use FW_CFG_ORDER_OVERRIDE_DEVICE rather than
FW_CFG_ORDER_OVERRIDE_USER? I don't have the slightest clue.

(I guess if I understood what commit bab47d9a75a3 was about, I'd be less
in doubt now. But that commit only hints at "avoid[ing] any future
issues of moving the file creation" -- I don't know what those issues
were in the first place!)

With (1) optionally fixed, and (2) fixed, I'd be willing to R-b this
patch; but I'm really thrown off by (3).

Thanks,
Laszlo


>      } else {
>          GError *err = NULL;
>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>


