Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B57C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4951120719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avl1VrPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4951120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKII-00022b-DS
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOK9C-0000xZ-Np
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOK9A-0005QV-BL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601641607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPD5ZkCdUHzN9In2eCSpp9UkEGz0LHZrsUBGkPO7z10=;
 b=avl1VrPNXNg+k3kojGWdpfGze2NDfFNKhRw3Aygkur5B2pZ7z5hD7vPEUaPIn3IAi8xaRR
 lobTLCr0OfiYGdLMR/oqeJELi/fur4HcomGe+lOFmMb0LfD1bbALmLezbS7cw440CiF2NJ
 TmzzvIwrjrq85hY7jo+RKsTARSqM2x0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-uJ-gQmSyNqKKXp4JFJJ8eQ-1; Fri, 02 Oct 2020 08:26:45 -0400
X-MC-Unique: uJ-gQmSyNqKKXp4JFJJ8eQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD8CA1005F70;
 Fri,  2 Oct 2020 12:26:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF55B5C1D7;
 Fri,  2 Oct 2020 12:26:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39F1E1132784; Fri,  2 Oct 2020 14:26:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 4/4] qemu-storage-daemon: Remove QemuOpts from
 --object parser
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-5-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 14:26:43 +0200
In-Reply-To: <20200930124557.51835-5-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 30 Sep 2020 14:45:57 +0200")
Message-ID: <874kncke4c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> The command line parser for --object parses the input twice: Once into
> QemuOpts just for detecting help options, and then again into a QDict
> using the keyval parser for actually creating the object.
>
> Now that the keyval parser can also detect help options, we can simplify
> this and remove the QemuOpts part.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  storage-daemon/qemu-storage-daemon.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
> index bb9cb740f0..7cbdbf0b23 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -264,21 +264,14 @@ static void process_options(int argc, char *argv[])
>              }
>          case OPTION_OBJECT:
>              {
> -                QemuOpts *opts;
> -                const char *type;
>                  QDict *args;
> +                bool help;
>  
> -                /* FIXME The keyval parser rejects 'help' arguments, so we must
> -                 * unconditionall try QemuOpts first. */
> -                opts = qemu_opts_parse(&qemu_object_opts,
> -                                       optarg, true, &error_fatal);
> -                type = qemu_opt_get(opts, "qom-type");
> -                if (type && user_creatable_print_help(type, opts)) {
> +                args = keyval_parse(optarg, "qom-type", &help, &error_fatal);
> +                if (help) {
> +                    user_creatable_print_help_from_qdict(args);
>                      exit(EXIT_SUCCESS);
>                  }
> -                qemu_opts_del(opts);
> -
> -                args = keyval_parse(optarg, "qom-type", NULL, &error_fatal);
>                  user_creatable_add_dict(args, true, &error_fatal);
>                  qobject_unref(args);
>                  break;

Reviewed-by: Markus Armbruster <armbru@redhat.com>


