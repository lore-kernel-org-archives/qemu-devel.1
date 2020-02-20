Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD5AC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264A1206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKTFR537"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264A1206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4rkd-0007bo-Ao
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 14:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4rk1-00077l-16
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 14:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4rjx-0001Lg-Rg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 14:44:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4rjx-0001Kj-HX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 14:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582227843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3i76gdIZRfvhWNwHfZ7IXpDljAFaxsjVHh4RcyQ8kA=;
 b=dKTFR537Py8AAdZvk/2jDtT68sf2iUZxm/t6yOAqQaMeUrgarXENT1oJF8tWXu7ucI80JU
 WlLXLLrhEw+vwpx5PCnHkmAI9YoR608mlw8GXpsxSkQ/WJfCzipJWSi9ObV00DBThSVxWF
 7f0HuNzbiMRFa8hgL54E4fKKlOU9B3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-k5BLm4uyOOSORW7BDIMneA-1; Thu, 20 Feb 2020 14:43:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48EC184B122;
 Thu, 20 Feb 2020 19:43:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B32689F28;
 Thu, 20 Feb 2020 19:43:54 +0000 (UTC)
Date: Thu, 20 Feb 2020 19:43:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel Cho <danielcho@qnap.com>
Subject: Re: The issues about architecture of the COLO checkpoint
Message-ID: <20200220194352.GI2836@work-vm>
References: <51f95ec9ed4a4cc682e63abf1414979b@intel.com>
 <b440cfb28e6c4aa38d79b93ed04a106f@intel.com>
 <CA+XQNE78cE-wMtNZBrXa+HQmuXmRGtjKJr_0JXaYPCEFEhXgwQ@mail.gmail.com>
 <20200213103752.GE2960@work-vm>
 <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
 <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
 <CA+XQNE49wq2nRKJ0CA4uHDZ4OUEbFGPKBfAWB4+UwPYgiZkrCw@mail.gmail.com>
 <5d030380-76d6-67c6-39a1-82c197e320b4@intel.com>
 <CA+XQNE6riKARXtP9oZaQjK9Gqgfh-+Ae8qX+WsWhGfMB0hf8tg@mail.gmail.com>
 <CA+XQNE6hdz1rZBvb1p=LFU1KtZbp5KGMxtz9Y_jWy9tZSNE-0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+XQNE6hdz1rZBvb1p=LFU1KtZbp5KGMxtz9Y_jWy9tZSNE-0Q@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: k5BLm4uyOOSORW7BDIMneA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel Cho (danielcho@qnap.com) wrote:
> Hi Hailiang,
>=20
> I have already patched the file to my branch, but there is a problem whil=
e
> doing migration.
> Here is the error message from SVM
> "qemu-system-x86_64: /root/download/qemu-4.1.0/memory.c:1079:
> memory_region_transaction_commit: Assertion `qemu_mutex_iothread_locked()=
'
> failed."

It's probably worth getting the full backtrace.

Dave

> Do you have this problem?
>=20
> Best regards,
> Daniel Cho
>=20
> Daniel Cho <danielcho@qnap.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:49=E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> > Hi Zhang,
> >
> > Thanks, I will configure on code for testing first.
> > However, if you have free time, could you please send the patch file to
> > us, Thanks.
> >
> > Best Regard,
> > Daniel Cho
> >
> >
> > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> >>
> >> On 2/18/2020 5:22 PM, Daniel Cho wrote:
> >>
> >> Hi Hailiang,
> >> Thanks for your help. If we have any problems we will contact you for
> >> your favor.
> >>
> >>
> >> Hi Zhang,
> >>
> >> " If colo-compare got a primary packet without related secondary packe=
t
> >> in a certain time , it will automatically trigger checkpoint.  "
> >> As you said, the colo-compare will trigger checkpoint, but does it nee=
d
> >> to limit checkpoint times?
> >> There is a problem about doing many checkpoints while we use fio to
> >> random write files. Then it will cause low throughput on PVM.
> >> Is this situation is normal on COLO?
> >>
> >>
> >> Hi Daniel,
> >>
> >> The checkpoint time is designed to be user adjustable based on user
> >> environment(workload/network status/business conditions...).
> >>
> >> In net/colo-compare.c
> >>
> >> /* TODO: Should be configurable */
> >> #define REGULAR_PACKET_CHECK_MS 3000
> >>
> >> If you need, I can send a patch for this issue. Make users can change =
the
> >> value by QMP and qemu monitor commands.
> >>
> >> Thanks
> >>
> >> Zhang Chen
> >>
> >>
> >>
> >> Best regards,
> >> Daniel Cho
> >>
> >> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8817=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >>>
> >>> On 2/15/2020 11:35 AM, Daniel Cho wrote:
> >>>
> >>> Hi Dave,
> >>>
> >>> Yes, I agree with you, it does need a timeout.
> >>>
> >>>
> >>> Hi Daniel and Dave,
> >>>
> >>> Current colo-compare already have the timeout mechanism.
> >>>
> >>> Named packet_check_timer,  It will scan primary packet queue to make
> >>> sure all the primary packet not stay too long time.
> >>>
> >>> If colo-compare got a primary packet without related secondary packet=
 in
> >>> a certain time , it will automatic trigger checkpoint.
> >>>
> >>> https://github.com/qemu/qemu/blob/master/net/colo-compare.c#L847
> >>>
> >>>
> >>> Thanks
> >>>
> >>> Zhang Chen
> >>>
> >>>
> >>>
> >>> Hi Hailiang,
> >>>
> >>> We base on qemu-4.1.0 for using COLO feature, in your patch, we found=
 a
> >>> lot of difference  between your version and ours.
> >>> Could you give us a latest release version which is close your
> >>> developing code?
> >>>
> >>> Thanks.
> >>>
> >>> Regards
> >>> Daniel Cho
> >>>
> >>> Dr. David Alan Gilbert <dgilbert@redhat.com> =E6=96=BC 2020=E5=B9=B42=
=E6=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >>>
> >>>> * Daniel Cho (danielcho@qnap.com) wrote:
> >>>> > Hi Hailiang,
> >>>> >
> >>>> > 1.
> >>>> >     OK, we will try the patch
> >>>> > =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D,
> >>>> > and thanks for your help.
> >>>> >
> >>>> > 2.
> >>>> >     We understand the reason to compare PVM and SVM's packet.
> >>>> However, the
> >>>> > empty of SVM's packet queue might happened on setting COLO feature
> >>>> and SVM
> >>>> > broken.
> >>>> >
> >>>> > On situation 1 ( setting COLO feature ):
> >>>> >     We could force do checkpoint after setting COLO feature finish=
,
> >>>> then it
> >>>> > will protect the state of PVM and SVM . As the Zhang Chen said.
> >>>> >
> >>>> > On situation 2 ( SVM broken ):
> >>>> >     COLO will do failover for PVM, so it might not cause any wrong=
 on
> >>>> PVM.
> >>>> >
> >>>> > However, those situations are our views, so there might be a big
> >>>> difference
> >>>> > between reality and our views.
> >>>> > If we have any wrong views and opinions, please let us know, and
> >>>> correct
> >>>> > us.
> >>>>
> >>>> It does need a timeout; the SVM being broken or being in a state whe=
re
> >>>> it never sends the corresponding packet (because of a state differen=
ce)
> >>>> can happen and COLO needs to timeout when the packet hasn't arrived
> >>>> after a while and trigger the checkpoint.
> >>>>
> >>>> Dave
> >>>>
> >>>> > Thanks.
> >>>> >
> >>>> > Best regards,
> >>>> > Daniel Cho
> >>>> >
> >>>> > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>>> >
> >>>> > > Add cc Jason Wang, he is a network expert.
> >>>> > >
> >>>> > > In case some network things goes wrong.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Thanks
> >>>> > >
> >>>> > > Zhang Chen
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > *From:* Zhang, Chen
> >>>> > > *Sent:* Thursday, February 13, 2020 10:10 AM
> >>>> > > *To:* 'Zhanghailiang' <zhang.zhanghailiang@huawei.com>; Daniel C=
ho
> >>>> <
> >>>> > > danielcho@qnap.com>
> >>>> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
> >>>> qemu-devel@nongnu.org
> >>>> > > *Subject:* RE: The issues about architecture of the COLO checkpo=
int
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > For the issue 2:
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > COLO need use the network packets to confirm PVM and SVM in the
> >>>> same state,
> >>>> > >
> >>>> > > Generally speaking, we can=E2=80=99t send PVM packets without co=
mpared with
> >>>> SVM
> >>>> > > packets.
> >>>> > >
> >>>> > > But to prevent jamming, I think COLO can do force checkpoint and
> >>>> send the
> >>>> > > PVM packets in this case.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Thanks
> >>>> > >
> >>>> > > Zhang Chen
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > *From:* Zhanghailiang <zhang.zhanghailiang@huawei.com>
> >>>> > > *Sent:* Thursday, February 13, 2020 9:45 AM
> >>>> > > *To:* Daniel Cho <danielcho@qnap.com>
> >>>> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
> >>>> qemu-devel@nongnu.org;
> >>>> > > Zhang, Chen <chen.zhang@intel.com>
> >>>> > > *Subject:* RE: The issues about architecture of the COLO checkpo=
int
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Hi,
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > 1.       After re-walked through the codes, yes, you are right,
> >>>> actually,
> >>>> > > after the first migration, we will keep dirty log on in primary
> >>>> side,
> >>>> > >
> >>>> > > And only send the dirty pages in PVM to SVM. The ram cache in
> >>>> secondary
> >>>> > > side is always a backup of PVM, so we don=E2=80=99t have to
> >>>> > >
> >>>> > > Re-send the none-dirtied pages.
> >>>> > >
> >>>> > > The reason why the first checkpoint takes longer time is we have=
 to
> >>>> backup
> >>>> > > the whole VM=E2=80=99s ram into ram cache, that is colo_init_ram=
_cache().
> >>>> > >
> >>>> > > It is time consuming, but I have optimized in the second patch
> >>>> > > =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=
=9D which you can
> >>>> find in my
> >>>> > > previous reply.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Besides, I found that, In my previous reply =E2=80=9CWe can only=
 copy the
> >>>> pages
> >>>> > > that dirtied by PVM and SVM in last checkpoint.=E2=80=9D,
> >>>> > >
> >>>> > > We have done this optimization in current upstream codes.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > 2=EF=BC=8EI don=E2=80=99t quite understand this question. For CO=
LO, we always need
> >>>> both
> >>>> > > network packets of PVM=E2=80=99s and SVM=E2=80=99s to compare be=
fore send this
> >>>> packets to
> >>>> > > client.
> >>>> > >
> >>>> > > It depends on this to decide whether or not PVM and SVM are in s=
ame
> >>>> state.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Thanks,
> >>>> > >
> >>>> > > hailiang
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > *From:* Daniel Cho [mailto:danielcho@qnap.com <danielcho@qnap.co=
m>]
> >>>> > > *Sent:* Wednesday, February 12, 2020 4:37 PM
> >>>> > > *To:* Zhang, Chen <chen.zhang@intel.com>
> >>>> > > *Cc:* Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr. David
> >>>> Alan
> >>>> > > Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu.org
> >>>> > > *Subject:* Re: The issues about architecture of the COLO checkpo=
int
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Hi Hailiang,
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Thanks for your replaying and explain in detail.
> >>>> > >
> >>>> > > We will try to use the attachments to enhance memory copy.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > However, we have some questions for your replying.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > 1.  As you said, "for each checkpoint, we have to send the whole
> >>>> PVM's
> >>>> > > pages To SVM", why the only first checkpoint will takes more pau=
se
> >>>> time?
> >>>> > >
> >>>> > > In our observing, the first checkpoint will take more time for
> >>>> pausing,
> >>>> > > then other checkpoints will takes a few time for pausing. Does i=
t
> >>>> means
> >>>> > > only the first checkpoint will send the whole pages to SVM, and =
the
> >>>> other
> >>>> > > checkpoints send the dirty pages to SVM for reloading?
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > 2. We notice the COLO-COMPARE component will stuck the packet un=
til
> >>>> > > receive packets from PVM and SVM, as this rule, when we add the
> >>>> > > COLO-COMPARE to PVM, its network will stuck until SVM start. So =
it
> >>>> is an
> >>>> > > other issue to make PVM stuck while setting COLO feature. With t=
his
> >>>> issue,
> >>>> > > could we let colo-compare to pass the PVM's packet when the SVM'=
s
> >>>> packet
> >>>> > > queue is empty? Then, the PVM's network won't stock, and "if PVM
> >>>> runs
> >>>> > > firstly, it still need to wait for The network packets from SVM =
to
> >>>> > > compare before send it to client side" won't happened either.
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Best regard,
> >>>> > >
> >>>> > > Daniel Cho
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=
=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:45=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>>> > >
> >>>> > >
> >>>> > >
> >>>> > > > -----Original Message-----
> >>>> > > > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> >>>> > > > Sent: Wednesday, February 12, 2020 11:18 AM
> >>>> > > > To: Dr. David Alan Gilbert <dgilbert@redhat.com>; Daniel Cho
> >>>> > > > <danielcho@qnap.com>; Zhang, Chen <chen.zhang@intel.com>
> >>>> > > > Cc: qemu-devel@nongnu.org
> >>>> > > > Subject: RE: The issues about architecture of the COLO checkpo=
int
> >>>> > > >
> >>>> > > > Hi,
> >>>> > > >
> >>>> > > > Thank you Dave,
> >>>> > > >
> >>>> > > > I'll reply here directly.
> >>>> > > >
> >>>> > > > -----Original Message-----
> >>>> > > > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> >>>> > > > Sent: Wednesday, February 12, 2020 1:48 AM
> >>>> > > > To: Daniel Cho <danielcho@qnap.com>; chen.zhang@intel.com;
> >>>> > > > Zhanghailiang <zhang.zhanghailiang@huawei.com>
> >>>> > > > Cc: qemu-devel@nongnu.org
> >>>> > > > Subject: Re: The issues about architecture of the COLO checkpo=
int
> >>>> > > >
> >>>> > > >
> >>>> > > > cc'ing in COLO people:
> >>>> > > >
> >>>> > > >
> >>>> > > > * Daniel Cho (danielcho@qnap.com) wrote:
> >>>> > > > > Hi everyone,
> >>>> > > > >      We have some issues about setting COLO feature. Hope
> >>>> somebody
> >>>> > > > > could give us some advice.
> >>>> > > > >
> >>>> > > > > Issue 1:
> >>>> > > > >      We dynamic to set COLO feature for PVM(2 core, 16G
> >>>> memory),  but
> >>>> > > > > the Primary VM will pause a long time(based on memory size) =
for
> >>>> > > > > waiting SVM start. Does it have any idea to reduce the pause
> >>>> time?
> >>>> > > > >
> >>>> > > >
> >>>> > > > Yes, we do have some ideas to optimize this downtime.
> >>>> > > >
> >>>> > > > The main problem for current version is, for each checkpoint, =
we
> >>>> have to
> >>>> > > > send the whole PVM's pages
> >>>> > > > To SVM, and then copy the whole VM's state into SVM from ram
> >>>> cache, in
> >>>> > > > this process, we need both of them be paused.
> >>>> > > > Just as you said, the downtime is based on memory size.
> >>>> > > >
> >>>> > > > So firstly, we need to reduce the sending data while do
> >>>> checkpoint,
> >>>> > > actually,
> >>>> > > > we can migrate parts of PVM's dirty pages in background
> >>>> > > > While both of VMs are running. And then we load these pages in=
to
> >>>> ram
> >>>> > > > cache (backup memory) in SVM temporarily. While do checkpoint,
> >>>> > > > We just send the last dirty pages of PVM to slave side and the=
n
> >>>> copy the
> >>>> > > ram
> >>>> > > > cache into SVM. Further on, we don't have
> >>>> > > > To send the whole PVM's dirty pages, we can only send the page=
s
> >>>> that
> >>>> > > > dirtied by PVM or SVM during two checkpoints. (Because
> >>>> > > > If one page is not dirtied by both PVM and SVM, the data of th=
is
> >>>> pages
> >>>> > > will
> >>>> > > > keep same in SVM, PVM, backup memory). This method can reduce
> >>>> > > > the time that consumed in sending data.
> >>>> > > >
> >>>> > > > For the second problem, we can reduce the memory copy by two
> >>>> methods,
> >>>> > > > first one, we don't have to copy the whole pages in ram cache,
> >>>> > > > We can only copy the pages that dirtied by PVM and SVM in last
> >>>> > > checkpoint.
> >>>> > > > Second, we can use userfault missing function to reduce the
> >>>> > > > Time consumed in memory copy. (For the second time, in theory,=
 we
> >>>> can
> >>>> > > > reduce time consumed in memory into ms level).
> >>>> > > >
> >>>> > > > You can find the first optimization in attachment, it is based=
 on
> >>>> an old
> >>>> > > qemu
> >>>> > > > version (qemu-2.6), it should not be difficult to rebase it
> >>>> > > > Into master or your version. And please feel free to send the =
new
> >>>> > > version if
> >>>> > > > you want into community ;)
> >>>> > > >
> >>>> > > >
> >>>> > >
> >>>> > > Thanks Hailiang!
> >>>> > > By the way, Do you have time to push the patches to upstream?
> >>>> > > I think this is a better and faster option.
> >>>> > >
> >>>> > > Thanks
> >>>> > > Zhang Chen
> >>>> > >
> >>>> > > > >
> >>>> > > > > Issue 2:
> >>>> > > > >      In
> >>>> > > > > https://github.com/qemu/qemu/blob/master/migration/colo.c#L5=
03,
> >>>> > > > > could we move start_vm() before Line 488? Because at first
> >>>> checkpoint
> >>>> > > > > PVM will wait for SVM's reply, it cause PVM stop for a while=
.
> >>>> > > > >
> >>>> > > >
> >>>> > > > No, that makes no sense, because if PVM runs firstly, it still
> >>>> need to
> >>>> > > wait for
> >>>> > > > The network packets from SVM to compare before send it to clie=
nt
> >>>> side.
> >>>> > > >
> >>>> > > >
> >>>> > > > Thanks,
> >>>> > > > Hailiang
> >>>> > > >
> >>>> > > > >      We set the COLO feature on running VM, so we hope the
> >>>> running VM
> >>>> > > > > could continuous service for users.
> >>>> > > > > Do you have any suggestions for those issues?
> >>>> > > > >
> >>>> > > > > Best regards,
> >>>> > > > > Daniel Cho
> >>>> > > > --
> >>>> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>> > >
> >>>> > >
> >>>> --
> >>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>>
> >>>>
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


