Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2457C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCD5206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qcwcf4Dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCD5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbU1o-0002Pl-M2
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 15:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbU0R-0000RT-BM
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:03:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbU0P-0005ZL-Ox
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590001432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JY5n92pu6fG92Dzw+7m2L38OC54A8FSYmWaVa0G4uaI=;
 b=Qcwcf4Dk/SDa+XBec3kVNXSqKLoWOAQ4GnoOreE7xdJZplyFTnOzWapXRJojDwJUW/b6qU
 oFhIiXCI0tbSWU0Q5jjhiIVxe4qnv9EZOz1lKDLe7sr3DY6JW7CWevm8dqDmmg9yjlImNF
 NfHdB4cId4xqfS0idQBR78Urnm1zXqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-IVSfctbfMbOnCnw66BJWnA-1; Wed, 20 May 2020 15:03:50 -0400
X-MC-Unique: IVSfctbfMbOnCnw66BJWnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB2C5461;
 Wed, 20 May 2020 19:03:48 +0000 (UTC)
Received: from work-vm (ovpn-114-169.ams2.redhat.com [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 916757D96E;
 Wed, 20 May 2020 19:03:47 +0000 (UTC)
Date: Wed, 20 May 2020 20:03:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] hmp: Simplify qom_set
Message-ID: <20200520190344.GG2820@work-vm>
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-3-dgilbert@redhat.com>
 <1f627a6b-9c5f-09b3-8f75-64e95a4f5d02@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1f627a6b-9c5f-09b3-8f75-64e95a4f5d02@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 15:03:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: clg@kaod.org, berrange@redhat.com, qemu-devel@nongnu.org, afaerber@suse.de,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> On 5/20/20 5:11 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Simplify qom_set by making it use qmp_qom_set and the JSON parser.
> > 
> > Note that qom-set likes JSON strings quoted with ' not ", e.g.:
> > 
> > (qemu) qom-get /machine smm
> > "auto"
> > (qemu) qom-set /machine smm 'auto'
> 
> Will I get this output using "?
> 
> (qemu) qom-set /machine smm "auto"
> Error: Expecting a JSON value

The error you get is:

(qemu) qom-set /machine smm "auto"
Error: JSON parse error, invalid keyword 'auto'

I think, having seen alphanumerics, it's expecting a keyword;
i.e. a true/false making a bool, or a null.

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   qom/qom-hmp-cmds.c | 16 +++++-----------
> >   1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> > index a8b0a080c7..f704b6949a 100644
> > --- a/qom/qom-hmp-cmds.c
> > +++ b/qom/qom-hmp-cmds.c
> > @@ -48,19 +48,13 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
> >       const char *property = qdict_get_str(qdict, "property");
> >       const char *value = qdict_get_str(qdict, "value");
> >       Error *err = NULL;
> > -    bool ambiguous = false;
> > -    Object *obj;
> > +    QObject *obj;
> > -    obj = object_resolve_path(path, &ambiguous);
> > -    if (obj == NULL) {
> > -        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> > -                  "Device '%s' not found", path);
> > -    } else {
> > -        if (ambiguous) {
> > -            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
> > -        }
> > -        object_property_parse(obj, value, property, &err);
> > +    obj = qobject_from_json(value, &err);
> > +    if (err == NULL) {
> > +        qmp_qom_set(path, property, obj, &err);
> >       }
> > +
> >       hmp_handle_error(mon, err);
> >   }
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


