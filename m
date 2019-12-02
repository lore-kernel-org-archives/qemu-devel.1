Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E491C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A27215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaCOpeS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A27215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiTz-0002BR-2S
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ibiTA-0001GB-Db
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ibiT8-0000IO-VS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:58:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ibiT8-0000IB-Qd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575280694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DoQjqtKiO+wLMO/C6JV6eAEIMlOsk026ELoCt+CmNE=;
 b=aaCOpeS/KWnI7zqUgUei/X0VGCAq/UyLjl6RElUCJiMI2CxWdj2OVwemPZdTb7JPgK+FRG
 bTQSeUQiyZ8oEifnPMJQMaKnbGy6Pw+sSkYcSPS7cdwHoNfF1GF2/VvsRsR7Rg0PjEeaji
 iKUH6a5/mpg+gbXO5ZdxsI++VtZZArs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-P2p2JVGgOD69RUtzYMXTbQ-1; Mon, 02 Dec 2019 04:58:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3DD7800D4E;
 Mon,  2 Dec 2019 09:58:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E57260BF7;
 Mon,  2 Dec 2019 09:58:08 +0000 (UTC)
Date: Mon, 2 Dec 2019 09:58:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel Cho <danielcho@qnap.com>
Subject: Re: Network connection with COLO VM
Message-ID: <20191202095806.GA2904@work-vm>
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: P2p2JVGgOD69RUtzYMXTbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>,
 "lukasstraub2@web.de" <lukasstraub2@web.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel Cho (danielcho@qnap.com) wrote:
> Hi Zhang,
>=20
> We use qemu-4.1.0 release on this case.
>=20
> I think we need use block mirror to sync the disk to secondary node first=
,
> then stop the primary VM and build COLO system.
>=20
> In the stop moment, you need add some netfilter and chardev socket node f=
or
> COLO, maybe you need re-check this part.
>=20
>=20
> Our test was already follow those step. Maybe I could describe the detail
> of the test flow and issues.
>=20
>=20
> Step 1:
>=20
> Create primary VM without any netfilter and chardev for COLO, and using
> other host ping primary VM continually.
>=20
>=20
> Step 2:
>=20
> Create secondary VM (the same device/drive with primary VM), and do block
> mirror sync ( ping to primary VM normally )
>=20
>=20
> Step 3:
>=20
> After block mirror sync finish, add those netfilter and chardev to primar=
y
> VM and secondary VM for COLO ( *Can't* ping to primary VM but those packe=
ts
> will be received later )
>=20
>=20
> Step 4:
>=20
> Start migrate primary VM to secondary VM, and primary VM & secondary VM a=
re
> running ( ping to primary VM works and receive those packets on step 3
> status )
>=20
>=20
>=20
>=20
> Between Step 3 to Step 4, it will take 10~20 seconds in our environment.
>=20
> I could image this issue (delay reply packets) is because of setting COLO
> proxy for temporary status,
>=20
> but we thought 10~20 seconds might a little long. (If primary VM is alrea=
dy
> doing some jobs, it might lose the data.)
>=20
>=20
> Could we reduce those time? or those delay is depends on different VM?

I think you need to set up the netfilter and chardev on the primary at
the start;  the filter contains the state of the TCP connections working
with the VM, so adding it later can't gain that state for existing
connections.

Dave

>=20
> Best Regard,
>=20
> Daniel Cho.
>=20
>=20
>=20
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
>=20
> >
> >
> >
> >
> > *From:* Daniel Cho <danielcho@qnap.com>
> > *Sent:* Friday, November 29, 2019 10:43 AM
> > *To:* Zhang, Chen <chen.zhang@intel.com>
> > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>; lukasstraub2@web.de=
;
> > qemu-devel@nongnu.org
> > *Subject:* Re: Network connection with COLO VM
> >
> >
> >
> > Hi David,  Zhang,
> >
> >
> >
> > Thanks for replying my question.
> >
> > We know why will occur this issue.
> >
> > As you said, the COLO VM's network needs
> >
> > colo-proxy to control packets, so the guest's
> >
> > interface should set the filter to solve the problem.
> >
> >
> >
> > But we found another question, when we set the
> >
> > fault-tolerance feature to guest (primary VM is running,
> >
> > secondary VM is pausing), the guest's network would not
> >
> > responds any request for a while (in our environment
> >
> > about 20~30 secs) after secondary VM runs.
> >
> >
> >
> > Does it be a normal situation, or a known issue?
> >
> >
> >
> > Our test is creating primary VM for a while, then creating
> >
> > secondary VM to make it with COLO feature.
> >
> >
> >
> > Hi Daniel,
> >
> >
> >
> > Happy to hear you have solved ssh disconnection issue.
> >
> >
> >
> > Do you use Lukas=E2=80=99s patch on this case?
> >
> > I think we need use block mirror to sync the disk to secondary node fir=
st,
> > then stop the primary VM and build COLO system.
> >
> > In the stop moment, you need add some netfilter and chardev socket node
> > for COLO, maybe you need re-check this part.
> >
> >
> >
> > Best Regard,
> >
> > Daniel Cho
> >
> >
> >
> > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> >
> >
> > > -----Original Message-----
> > > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Sent: Wednesday, November 27, 2019 6:51 PM
> > > To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> > > <chen.zhang@intel.com>; lukasstraub2@web.de
> > > Cc: qemu-devel@nongnu.org
> > > Subject: Re: Network connection with COLO VM
> > >
> > > * Daniel Cho (danielcho@qnap.com) wrote:
> > > > Hello everyone,
> > > >
> > > > Could we ssh to colo VM (means PVM & SVM are starting)?
> > > >
> > >
> > > Lets cc in Zhang Chen and Lukas Straub.
> >
> > Thanks Dave.
> >
> > >
> > > > SSH will connect to colo VM for a while, but it will disconnect wit=
h
> > > > error
> > > > *client_loop: send disconnect: Broken pipe*
> > > >
> > > > It seems to colo VM could not keep network session.
> > > >
> > > > Does it be a known issue?
> > >
> > > That sounds like the COLO proxy is getting upset; it's supposed to
> > compare
> > > packets sent by the primary and secondary and only send one to the
> > outside
> > > - you shouldn't be talking directly to the guest, but always via the
> > proxy.  See
> > > docs/colo-proxy.txt
> > >
> >
> > Hi Daniel,
> >
> > I have try ssh to COLO guest with 8 hours, not occurred this issue.
> > Please check your network/qemu configuration.
> > But I found another problem maybe related this issue, if no network
> > communication for a period of time(maybe 10min), the first message send=
 to
> > guest have a chance with delay(maybe 1-5 sec), I will try to fix it whe=
n I
> > have time.
> >
> > Thanks
> > Zhang Chen
> >
> > > Dave
> > >
> > > > Best Regard,
> > > > Daniel Cho
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


