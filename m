Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C0BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482592086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvXGTfcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482592086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZzT-0004zc-Gx
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBZyX-0004XV-E6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:43:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kBZyT-0007aY-VO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598604183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAbsxV5fYKoCQrg7yuswaDQfZhHoaBYUH2XOgrtqs2s=;
 b=RvXGTfcJC7AMbqNxqbubw8OsorwovpBOBSkKYD2sCN8m+rXJxINwRo8xA28ATVZ9mE+2l5
 bvmvpPAvKXixUwQWGN07J+ae8vvuF4bYSDsxvv3J4RTIiLAXq3Fi0JzLYpoImPa2o1TkXG
 L1aj6iWHD+Jfy3Uemwmh9cGNwbROhs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-PK8kU-QPPT-hFdubkmIL8A-1; Fri, 28 Aug 2020 04:43:00 -0400
X-MC-Unique: PK8kU-QPPT-hFdubkmIL8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2841007471;
 Fri, 28 Aug 2020 08:42:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DFC65D9F3;
 Fri, 28 Aug 2020 08:42:51 +0000 (UTC)
Date: Fri, 28 Aug 2020 10:42:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200828104249.04c39c12@redhat.com>
In-Reply-To: <f58e6200-b058-5f59-addc-13ca602ce745@amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
 <f602852c-b6af-694e-3e32-47974722e144@amd.com>
 <20200825081504.GA2646@work-vm>
 <20200825163846.10185087@redhat.com>
 <20200825152521.GA3574@work-vm>
 <20200826144324.56335302@redhat.com>
 <20200826141046.GB2727@work-vm>
 <20200827231907.10cfe4b7@imammedo-mac>
 <f58e6200-b058-5f59-addc-13ca602ce745@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 03:48:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 17:58:01 -0500
Babu Moger <babu.moger@amd.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Thursday, August 27, 2020 4:19 PM
> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> > rth@twiddle.net
> > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> > generic decode
> > 
> > On Wed, 26 Aug 2020 15:10:46 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >   
> > > * Igor Mammedov (imammedo@redhat.com) wrote:  
> > > > On Tue, 25 Aug 2020 16:25:21 +0100
> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > >  
> > > > > * Igor Mammedov (imammedo@redhat.com) wrote:  
> > > > > > On Tue, 25 Aug 2020 09:15:04 +0100 "Dr. David Alan Gilbert"
> > > > > > <dgilbert@redhat.com> wrote:
> > > > > >  
> > > > > > > * Babu Moger (babu.moger@amd.com) wrote:  
> > > > > > > > Hi Dave,
> > > > > > > >
> > > > > > > > On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:  
> > > > > > > > > * Babu Moger (babu.moger@amd.com) wrote:  
> > > > > > > > >> To support some of the complex topology, we introduced EPYC  
> > mode apicid decode.  
> > > > > > > > >> But, EPYC mode decode is running into problems. Also it
> > > > > > > > >> can become quite a maintenance problem in the future. So,
> > > > > > > > >> it was decided to remove that code and use the generic
> > > > > > > > >> decode which works for majority of the topology. Most of
> > > > > > > > >> the SPECed configuration would work just fine. With some  
> > non-SPECed user inputs, it will create some sub-optimal configuration.  
> > > > > > > > >> Here is the discussion thread.
> > > > > > > > >> https://nam11.safelinks.protection.outlook.com/?url=https
> > > > > > > > >> %3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-  
> > 1d84-a6e  
> > > > > > > > >> 7-e468-  
> > d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.  
> > > > > > > > >>  
> > moger%40amd.com%7C9b15ee395daa4935640408d84acedf13%7C3dd8  
> > > > > > > > >>  
> > 961fe4884e608e11a82d994e183d%7C0%7C0%7C637341599663177545  
> > > > > > > > >>  
> > &amp;sdata=4okYGU%2F8QTYqEOZEd1EBC%2BEsIIrEV59HZrHzpbsR8s  
> > > > > > > > >> U%3D&amp;reserved=0
> > > > > > > > >>
> > > > > > > > >> This series removes all the EPYC mode specific apicid changes  
> > and use the generic  
> > > > > > > > >> apicid decode.  
> > > > > > > > >
> > > > > > > > > Hi Babu,
> > > > > > > > >   This does simplify things a lot!
> > > > > > > > > One worry, what happens about a live migration of a VM from  
> > an old qemu  
> > > > > > > > > that was using the node-id to a qemu with this new scheme?  
> > > > > > > >
> > > > > > > > The node_id which we introduced was only used internally. This  
> > wasn't  
> > > > > > > > exposed outside. I don't think live migration will be an issue.  
> > > > > > >
> > > > > > > Didn't it become part of the APIC ID visible to the guest?  
> > > > > >
> > > > > > Daniel asked similar question wrt hard error on start up, when
> > > > > > CLI is not sufficient to create EPYC cpu.
> > > > > >
> > > > > >  
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%  
> > > > > > 2Fwww.mail-archive.com%2Fqemu-  
> > devel%40nongnu.org%2Fmsg728536.htm  
> > > > > >  
> > l&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C9b15ee395daa49356
> > 404  
> > > > > >  
> > 08d84acedf13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63734
> > 1  
> > > > > >  
> > 599663177545&amp;sdata=OnHz23W4F4TdYwlxPZwC%2B8YRY1K3qJ5U9Sfdo
> > Oc  
> > > > > > GXtw%3D&amp;reserved=0
> > > > > >
> > > > > > Migration might fall into the same category.
> > > > > > Also looking at the history, 5.0 commit
> > > > > >   247b18c593ec29 target/i386: Enable new apic id encoding for
> > > > > > EPYC based cpus models silently broke APIC ID (without versioning),  
> > for all EPYC models (that's were 1 new and 1 old one).  
> > > > > >
> > > > > > (I'm not aware of somebody complaining about it)
> > > > > >
> > > > > > Another commit ed78467a21459, changed CPUID_8000_001E without  
> > versioning as well.  
> > > > > >
> > > > > >
> > > > > > With current EPYC apicid code, if all starts align (no numa or 1
> > > > > > numa node only on CLI and no -smp dies=) it might produce a valid  
> > CPU (apicid+CPUID_8000_001E).  
> > > > > > No numa is gray area, since EPYC spec implies that it has to be numa  
> > machine in case of real EPYC cpus.  
> > > > > > Multi-node configs would be correct only if user assigns cpus to
> > > > > > numa nodes by duplicating internal node_id algorithm that this series  
> > removes.  
> > > > > >
> > > > > > There might be other broken cases that I don't recall anymore
> > > > > > (should be mentioned in previous versions of this series)
> > > > > >
> > > > > >
> > > > > > To summarize from migration pov (ignoring ed78467a21459 change):
> > > > > >
> > > > > >  1) old qemu pre-5.0 ==>  qemu 5.0, 5.1 - broken migration  
> > > > >
> > > > > Oh ....
> > > > >  
> > > > > >  2) with this series (lets call it qemu 5.2)
> > > > > >      pre-5.0 ==> qemu 5.2 - should work as series basically rollbacks  
> > current code to pre-5.0  
> > > > > >      qemu 5.0, 5.1 ==> qemu 5.2 - broken
> > > > > >
> > > > > > It's all about picking which poison to choose, I'd preffer 2nd
> > > > > > case as it lets drop a lot of complicated code that doesn't work
> > > > > > as expected.  
> > > > >
> > > > > I think that would make our lives easier for other reasons; so I'm
> > > > > happy to go with that.  
> > > >
> > > > to make things less painful for users, me wonders if there is a way
> > > > to block migration if epyc and specific QEMU versions are used?  
> > >
> > > We have no way to block based on version - and that's a pretty painful
> > > thing to do; we can block based on machine type.
> > >
> > > But before we get there; can we understand in which combinations that
> > > things break and why exactly - would it break on a 1 or 2 vCPU guest -
> > > or would it only break when we get to the point the upper bits start
> > > being used for example?  Why exaclty would it break - i.e. is it going
> > > to change the name of sections in the migration stream - or are the
> > > values we need actually going to migrate OK?  
> > 
> > it's values of APIC ID, where 4.2 and 5.0 QEMU use different values if numa is
> > enabled.
> > I'd expect guest to be very confused in when this happens.
> > 
> > here is an example:
> > qemu-4.2 -cpu EPYC -smp 8,sockets=1,cores=8 -numa node,cpus=0-3 -numa
> > node,cpus=4-7
> > 
> > (QEMU) qom-get path=/machine/unattached/device[8] property=apic-id {
> >     "return": 7
> > }
> > 
> > vs
> > 
> > qemu-5.1 -cpu EPYC -smp 8,sockets=1,cores=8 -numa node,cpus=0-3 -numa
> > node,cpus=4-7
> > (QEMU) qom-get path=/machine/unattached/device[8] property=apic-id {
> >     "return": 15
> > }
> > 
> > we probably can't do anything based on machine type versions, as
> > 4.2 and older versions on qemu-5.0 and newer use different algorithm to
> > calculate apic-id.
> > 
> > Hence was suggestion to leave 5.0/5.1 with broken apic id and revert back to
> > 4.2 algorithm, which should encode APIC ID correctly when '-smp dies' is
> > used.  
> 
> That is correct. When we revert all the node_id related changes, we will
> go back to 4.2 algorithm. It will work fine with user passing "-smp
> dies=n". It also keeps the code simple. That is why I kept the decoding of
> 0x8000001e like this below. This will also match apicid decoding.
> 
> *ecx = ((topo_info->dies_per_pkg - 1) << 8) |  ((cpu->apic_id >>
> apicid_die_offset(topo_info)) & 0xFF);
that will work when there is no -numa on CLI, when -numa is used,
we should use node id that user provided.
like you did in previous revision
   "[PATCH v4 1/3] i386: Simplify CPUID_8000_001E for AMD"

> Still not clear if we need to add a warning when numa nodes != dies.
> Worried about adding that check and remove it again later.
Since there is objection wrt making it error and I'd go with warning for now,
it makes life of person who have to figure what's wrong a bit easier.

> What about auto_enable_numa? Do we still need it?
>
> 
> I can send the patches tomorrow if these things are clarified.
> Thanks
With auto_enable_numa it would be cleaner as you can reuse
the same numa code to set 0x8000001e.ecx vs hardcodding it as above.

Maybe post series without auto_enable_numa so we fix migration
regression ASAP and then switch to auto_enable_numa on top.


> 
> > 
> >   
> > > Dave
> > >
> > >  
> > > > > > PS:
> > > > > >  I didn't review it yet, but with this series we aren't  making
> > > > > > up internal node_ids that should match user provided numa node ids  
> > somehow.  
> > > > > >  It seems series lost the patch that would enforce numa in case
> > > > > > -smp dies>1,  but otherwise it heads in the right direction.  
> > > > >
> > > > > Dave
> > > > >  
> > > > > > >
> > > > > > > Dave
> > > > > > >  
> > > > > >  
> > > >  
> 


