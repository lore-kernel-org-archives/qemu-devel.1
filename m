Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E55C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF98F2070A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHhvOKT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF98F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8IM-0008Db-SF
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ic8BG-0004jW-4O
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ic8BB-00026r-D8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:25:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ic8B3-00021y-BP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575379514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDnJnLgwiGIsoGWH4Exv3XCYHaGzgO98+m1HYNrpak4=;
 b=hHhvOKT7tEzD1kOr+pnAho6Is05jivW+/sSa23Dvg7tSOBBKe4K5gy7e8YyQ2CuavsdIJV
 MnznbBP/M4+usgUaGc6Kilz1U0+qbE46xkw21kEWWpc5nTbV0FRod3RL2CaV+YEgAkhnkk
 yMSJUzj41CFCWAE64gXstNy+3EGue8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-tBhj-tsyMBCrWcKRSPPKqw-1; Tue, 03 Dec 2019 08:25:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1001218543A2;
 Tue,  3 Dec 2019 13:25:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C053C5C3FD;
 Tue,  3 Dec 2019 13:25:06 +0000 (UTC)
Date: Tue, 3 Dec 2019 13:25:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel Cho <danielcho@qnap.com>
Subject: Re: Network connection with COLO VM
Message-ID: <20191203132504.GH3078@work-vm>
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
 <20191202095806.GA2904@work-vm>
 <CA+XQNE6pmj=-tMxCUamY3U4jNuBNR7=rjeFwhbps7a6YNAsYog@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+XQNE6pmj=-tMxCUamY3U4jNuBNR7=rjeFwhbps7a6YNAsYog@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tBhj-tsyMBCrWcKRSPPKqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Hi Dave,
>=20
> We could use the exist interface to add netfilter and chardev, it might n=
ot
> have the problem you said.
>=20
> However, the netfilter and chardev on the primary at the start, that mean=
s
> we could not dynamic set COLO
> feature to VM?

I wasn't expecting that to be possible - I'd expect you to be able
to start in a state that looks the same as a primary+failed secondary;
but I'm not sure.

> We try to change this chardev to prevent primary VM will stuck to wait
> secondary VM.
>=20
> -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,wait \
>=20
> to
>=20
> -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,nowait =
\
>=20
> But it will make primary VM's network not works. (Can't get ip), until
> starting connect with secondary VM.

I'm not sure of the answer to this; I've not tried doing it - I'm not
sure anyone has!
But, the colo components do track the state of tcp connections, so I'm
expecting that they have to already exist to have the state of those
connections available for when you start the secondary.


> Otherwise, the primary VM with netfileter / chardev and without netfilter=
 /
> chardev , they takes very different
> booting time.
> Without  netfilter / chardev : about 1 mins
> With   netfilter / chardev : about 5 mins
> Is this an issue?

that sounds like it needs investigating.

Dave

> Best regards,
> Daniel Cho
>=20
>=20
> Dr. David Alan Gilbert <dgilbert@redhat.com> =E6=96=BC 2019=E5=B9=B412=E6=
=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=81=
=93=EF=BC=9A
>=20
> > * Daniel Cho (danielcho@qnap.com) wrote:
> > > Hi Zhang,
> > >
> > > We use qemu-4.1.0 release on this case.
> > >
> > > I think we need use block mirror to sync the disk to secondary node
> > first,
> > > then stop the primary VM and build COLO system.
> > >
> > > In the stop moment, you need add some netfilter and chardev socket no=
de
> > for
> > > COLO, maybe you need re-check this part.
> > >
> > >
> > > Our test was already follow those step. Maybe I could describe the de=
tail
> > > of the test flow and issues.
> > >
> > >
> > > Step 1:
> > >
> > > Create primary VM without any netfilter and chardev for COLO, and usi=
ng
> > > other host ping primary VM continually.
> > >
> > >
> > > Step 2:
> > >
> > > Create secondary VM (the same device/drive with primary VM), and do b=
lock
> > > mirror sync ( ping to primary VM normally )
> > >
> > >
> > > Step 3:
> > >
> > > After block mirror sync finish, add those netfilter and chardev to
> > primary
> > > VM and secondary VM for COLO ( *Can't* ping to primary VM but those
> > packets
> > > will be received later )
> > >
> > >
> > > Step 4:
> > >
> > > Start migrate primary VM to secondary VM, and primary VM & secondary =
VM
> > are
> > > running ( ping to primary VM works and receive those packets on step =
3
> > > status )
> > >
> > >
> > >
> > >
> > > Between Step 3 to Step 4, it will take 10~20 seconds in our environme=
nt.
> > >
> > > I could image this issue (delay reply packets) is because of setting =
COLO
> > > proxy for temporary status,
> > >
> > > but we thought 10~20 seconds might a little long. (If primary VM is
> > already
> > > doing some jobs, it might lose the data.)
> > >
> > >
> > > Could we reduce those time? or those delay is depends on different VM=
?
> >
> > I think you need to set up the netfilter and chardev on the primary at
> > the start;  the filter contains the state of the TCP connections workin=
g
> > with the VM, so adding it later can't gain that state for existing
> > connections.
> >
> > Dave
> >
> > >
> > > Best Regard,
> > >
> > > Daniel Cho.
> > >
> > >
> > >
> > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=88=
30=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > >
> > > >
> > > >
> > > >
> > > > *From:* Daniel Cho <danielcho@qnap.com>
> > > > *Sent:* Friday, November 29, 2019 10:43 AM
> > > > *To:* Zhang, Chen <chen.zhang@intel.com>
> > > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
> > lukasstraub2@web.de;
> > > > qemu-devel@nongnu.org
> > > > *Subject:* Re: Network connection with COLO VM
> > > >
> > > >
> > > >
> > > > Hi David,  Zhang,
> > > >
> > > >
> > > >
> > > > Thanks for replying my question.
> > > >
> > > > We know why will occur this issue.
> > > >
> > > > As you said, the COLO VM's network needs
> > > >
> > > > colo-proxy to control packets, so the guest's
> > > >
> > > > interface should set the filter to solve the problem.
> > > >
> > > >
> > > >
> > > > But we found another question, when we set the
> > > >
> > > > fault-tolerance feature to guest (primary VM is running,
> > > >
> > > > secondary VM is pausing), the guest's network would not
> > > >
> > > > responds any request for a while (in our environment
> > > >
> > > > about 20~30 secs) after secondary VM runs.
> > > >
> > > >
> > > >
> > > > Does it be a normal situation, or a known issue?
> > > >
> > > >
> > > >
> > > > Our test is creating primary VM for a while, then creating
> > > >
> > > > secondary VM to make it with COLO feature.
> > > >
> > > >
> > > >
> > > > Hi Daniel,
> > > >
> > > >
> > > >
> > > > Happy to hear you have solved ssh disconnection issue.
> > > >
> > > >
> > > >
> > > > Do you use Lukas=E2=80=99s patch on this case?
> > > >
> > > > I think we need use block mirror to sync the disk to secondary node
> > first,
> > > > then stop the primary VM and build COLO system.
> > > >
> > > > In the stop moment, you need add some netfilter and chardev socket =
node
> > > > for COLO, maybe you need re-check this part.
> > > >
> > > >
> > > >
> > > > Best Regard,
> > > >
> > > > Daniel Cho
> > > >
> > > >
> > > >
> > > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > Sent: Wednesday, November 27, 2019 6:51 PM
> > > > > To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> > > > > <chen.zhang@intel.com>; lukasstraub2@web.de
> > > > > Cc: qemu-devel@nongnu.org
> > > > > Subject: Re: Network connection with COLO VM
> > > > >
> > > > > * Daniel Cho (danielcho@qnap.com) wrote:
> > > > > > Hello everyone,
> > > > > >
> > > > > > Could we ssh to colo VM (means PVM & SVM are starting)?
> > > > > >
> > > > >
> > > > > Lets cc in Zhang Chen and Lukas Straub.
> > > >
> > > > Thanks Dave.
> > > >
> > > > >
> > > > > > SSH will connect to colo VM for a while, but it will disconnect
> > with
> > > > > > error
> > > > > > *client_loop: send disconnect: Broken pipe*
> > > > > >
> > > > > > It seems to colo VM could not keep network session.
> > > > > >
> > > > > > Does it be a known issue?
> > > > >
> > > > > That sounds like the COLO proxy is getting upset; it's supposed t=
o
> > > > compare
> > > > > packets sent by the primary and secondary and only send one to th=
e
> > > > outside
> > > > > - you shouldn't be talking directly to the guest, but always via =
the
> > > > proxy.  See
> > > > > docs/colo-proxy.txt
> > > > >
> > > >
> > > > Hi Daniel,
> > > >
> > > > I have try ssh to COLO guest with 8 hours, not occurred this issue.
> > > > Please check your network/qemu configuration.
> > > > But I found another problem maybe related this issue, if no network
> > > > communication for a period of time(maybe 10min), the first message
> > send to
> > > > guest have a chance with delay(maybe 1-5 sec), I will try to fix it
> > when I
> > > > have time.
> > > >
> > > > Thanks
> > > > Zhang Chen
> > > >
> > > > > Dave
> > > > >
> > > > > > Best Regard,
> > > > > > Daniel Cho
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >
> > > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


