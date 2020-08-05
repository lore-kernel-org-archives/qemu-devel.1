Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB3EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4AD2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKU30IAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4AD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GyU-00006N-Ca
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3GxV-0007Xa-AZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:47:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3GxS-0006zg-Bh
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596624460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tb/xBOOWsw/TomuhbMZ6wUY0aalRGbMJ15padGe0oKA=;
 b=NKU30IACYXyvZTTdnPBaBaX1USnA/aA5rK92S9d73NAV7g78j2N1IoMfnjuvMfBy20FXjh
 hnkTuGF47Jm059kEUGby33Nn6BD5Zj+XN4+gXuveaYr3TYghqaw3KdB9+GIWuWL9Dwul9x
 Tt0nosPmixrpHVvlf1lV7+4IhAebSY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-Z90DuQJHPGaX-0L1sHBVXg-1; Wed, 05 Aug 2020 06:47:39 -0400
X-MC-Unique: Z90DuQJHPGaX-0L1sHBVXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFC8107BEF5;
 Wed,  5 Aug 2020 10:47:35 +0000 (UTC)
Received: from work-vm (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19E1260C47;
 Wed,  5 Aug 2020 10:47:25 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:47:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 02/18] migration/vmstate: Introduce
 vmstate_no_state_to_migrate
Message-ID: <20200805104723.GC3004@work-vm>
References: <20200703201911.26573-1-f4bug@amsat.org>
 <20200703201911.26573-3-f4bug@amsat.org>
 <CAFEAcA_fsBtBnzarO4Obd7-5766oSuHzDqRrK48VqgDmH5ip+g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fsBtBnzarO4Obd7-5766oSuHzDqRrK48VqgDmH5ip+g@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 3 Jul 2020 at 21:19, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> >
> > Introduce a special state to indicate when an object doesn't
> > have anything in its state to migrate.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > ---
> >  include/migration/vmstate.h | 1 +
> >  migration/vmstate.c         | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index af7d80cd4e..0922bc8efa 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -195,6 +195,7 @@ struct VMStateDescription {
> >  };
> >
> >  extern const VMStateDescription vmstate_dummy; /* Exclusively for linux-user */
> > +extern const VMStateDescription vmstate_no_state_to_migrate;
> >
> >  extern const VMStateInfo vmstate_info_bool;
> >
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index bafa890384..d640cafad3 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -20,6 +20,13 @@
> >  #include "trace.h"
> >  #include "qjson.h"
> >
> > +const VMStateDescription vmstate_no_state_to_migrate = {
> > +    .name = "empty-state",
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> 
> Does this definitely not put any data into the migration stream?
> We don't want to change what's on the wire for machines that
> use devices that start using this. (If it does by default, it
> would be easy to make the migration code special case the
> magic symbol to act like "no vmsd specified").

I'd need to test it to be sure, but I think if we added a .needed
to vmstate_no_state_to_migrate with a function that always returned
false, then I think the stream would stay unchanged.

Dave

> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


