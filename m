Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB5A20747
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wv0shiml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB5A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcs8-0003OQ-Ja
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jWcqC-00012t-LH
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:29:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jWcqA-0005sN-0b
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:29:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0479Hu5j107945;
 Thu, 7 May 2020 09:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=qaEF2W7p4xQVdmrWWKxqqD3qaJ0mR/JvI0NTxzQfnsw=;
 b=Wv0shimlN1wvQOVEGYmVrGebPYUDNFi730OlXHTs04iKSYBzONWjGy8zF2MXjwyn+FrR
 /X/aM4/Fn3UOmY0q28LGY1Ok89fo37fZdYkv3s9puvE8iEE/CMElvXBzXRNGREU8FcUP
 lEAu4+qLUe5FoNVe0/Dgs9TpoVeAg4COZmu83bWGH25m5SvnotmzelC0SwM1OAfQxbD+
 ciBfZ5/op0AXyh+V42mfG0WvIehNtQ8StfflEW5762lI8LsjmZbhTEsDyCpzKyhxuTBJ
 KuRtQo2egQdZCsZycSXUs7p/9R3jON/dVUK+qlNpuSXjzN+hlYTZBZ0ZgNPRLJS+/5cn LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 30veckgffu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 May 2020 09:29:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0479CrMM164597;
 Thu, 7 May 2020 09:29:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 30sjdxme5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 May 2020 09:29:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0479T3eS027524;
 Thu, 7 May 2020 09:29:03 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 07 May 2020 02:29:03 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id C14946854F9D; Thu,  7 May 2020 10:29:00 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] chardev: enable distinct input for -chardev file
In-Reply-To: <20200507062442.15215-2-alxndr@bu.edu>
References: <20200507062442.15215-1-alxndr@bu.edu>
 <20200507062442.15215-2-alxndr@bu.edu>
Date: Thu, 07 May 2020 10:29:00 +0100
Message-ID: <m2pnbg6qlf.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=2
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070076
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 05:29:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 marcandre.lureau@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-05-07 at 02:24:41 -04, Alexander Bulekov wrote:
> char-file already supports distinct paths for input/output but it was
> only possible to specify a distinct input through QMP. With this change,
> we can also specify a distinct input with the -chardev file argument:
>     qemu -chardev file,id=char1,path=/out/file,pathin=/in/file
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  chardev/char-file.c | 5 +++++
>  chardev/char.c      | 3 +++
>  qemu-options.hx     | 7 +++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 2fd80707e5..031f2aa7d7 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -100,6 +100,7 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
>                                      Error **errp)
>  {
>      const char *path = qemu_opt_get(opts, "path");
> +    const char *pathin = qemu_opt_get(opts, "pathin");
>      ChardevFile *file;
>  
>      backend->type = CHARDEV_BACKEND_KIND_FILE;
> @@ -110,6 +111,10 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, ChardevBackend *backend,
>      file = backend->u.file.data = g_new0(ChardevFile, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
>      file->out = g_strdup(path);
> +    if (pathin) {
> +        file->has_in = true;
> +        file->in = g_strdup(pathin);
> +    }
>  
>      file->has_append = true;
>      file->append = qemu_opt_get_bool(opts, "append", false);
> diff --git a/chardev/char.c b/chardev/char.c
> index e77564060d..97e03a8e48 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -849,6 +849,9 @@ QemuOptsList qemu_chardev_opts = {
>          },{
>              .name = "path",
>              .type = QEMU_OPT_STRING,
> +        },{
> +            .name = "pathin",
> +            .type = QEMU_OPT_STRING,
>          },{
>              .name = "host",
>              .type = QEMU_OPT_STRING,
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 292d4e7c0c..488961099b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]\n"
>      "         [,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev ringbuf,id=id[,size=size][,logfile=PATH][,logappend=on|off]\n"
> -    "-chardev file,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> +    "-chardev file,id=id,path=path[,pathin=PATH][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev pipe,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>  #ifdef _WIN32
>      "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> @@ -3137,13 +3137,16 @@ The available backends are:
>      Create a ring buffer with fixed size ``size``. size must be a power
>      of two and defaults to ``64K``.
>  
> -``-chardev file,id=id,path=path``
> +``-chardev file,id=id,path=path[,pathin=pathin]``
>      Log all traffic received from the guest to a file.
>  
>      ``path`` specifies the path of the file to be opened. This file will
>      be created if it does not already exist, and overwritten if it does.
>      ``path`` is required.
>  
> +    ``pathin`` specifies a separate file as the input to the chardev. If
> +    ``pathin`` is omitted, ``path`` is used for both input and output
> +
>  ``-chardev pipe,id=id,path=path``
>      Create a two-way connection to the guest. The behaviour differs
>      slightly between Windows hosts and other hosts:
> -- 
> 2.26.2

