Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7576C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC456215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC456215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJ3d-0002SA-N6
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iGJ1k-000173-RT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iGJ1j-0007xc-2u
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iGJ1c-0007o5-Au; Fri, 04 Oct 2019 04:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 510E130A7BB5;
 Fri,  4 Oct 2019 08:33:13 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C65BF19C68;
 Fri,  4 Oct 2019 08:33:09 +0000 (UTC)
Date: Fri, 4 Oct 2019 10:33:07 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191004083307.GI6129@angien.pipo.sk>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
 <20191002104600.GC6129@angien.pipo.sk>
 <73dcfdd5-ede2-250e-4680-7c1408c5a3c3@redhat.com>
 <7b0ea320-4c77-2b0f-7f12-615aa0a6d8cd@virtuozzo.com>
 <53da72e0-d265-8d0f-e47c-8338c43081e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53da72e0-d265-8d0f-e47c-8338c43081e3@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 04 Oct 2019 08:33:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 03, 2019 at 19:34:56 -0400, John Snow wrote:
> On 10/3/19 6:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> > 03.10.2019 0:35, John Snow wrote:
> >> On 10/2/19 6:46 AM, Peter Krempa wrote:
> > ====

[...]

(I'm sorry if I ignored something which might require input in the
trimmed part but I don't have enough mental capacity to follow this
thread fully)

> > 
> > If it's a problem for libvirt to keep same node-names, why should we insist?
> > 
> > 
> 
> Is it really a problem? If libvirt requests migration of bitmaps, those
> bitmaps need to go somewhere. Even if it constructs a different graph
> for valid reasons, it should still understand which qcow2 nodes
> correlate to which other qcow2 nodes and name them accordingly.

Well, no it is not a problem. Since bitmap migration has a migration
capability and libvirt by default disables all unknown migration
capabilities we can deal with it.

We have measures to transfer state to the destination we can
basically do the equivalent of the explicit mapping but with extra
steps.

We know where we want to place the bitmap and thus we can configure
those nodes appropriately and generate new names for everything else so
that nothing gets accidentally copied to wrong place.

My concern is though about the future. Since this is the first instance
of such a  migration feature which requires node names it's okay because
we can cheat by naming the destination "appropriately". The problem
will start though if there will be something else bound to the backend
of a disk addressed by node names which will have different semantics.

In that case we won't be able to cheat again.

Let's assume the following example:

qemu adds a new feature of migrating the qcow2 L2 cache. This will
obviously have different implications on when it can be used than
bitmaps.

If we'd like to use either of the features but not both together on a
node there wouldn't be a possibility to achieve that.

The thing about bitmaps is that they are not really bound to the image
itself but rather the data in the image. As long as the user provides a
image with exactly the same contents the VM can use it and the bitmap
will be correct for it.

We use this in non-shared storage migration where we by default flatten
the backing chain into a new image. In such case a bitmap is still valid
but the cache in the hypothetical example is not valid to be copied over
for the same node name.

At the very least the nuances of the capability should be documented so
that we don't have to second guess what is going to happen.

> I don't see why this is actually a terrible constraint. Even in our
> mapping proposal we're still using node-names.
> 
> 
> So here's a summary of where I stand right now:
> 
> - I want an API in QEMU that doesn't require libvirt.
> 
> - I want to accommodate libvirt, but don't understand the requirement
> that node-names must be ephemeral.

As I've outlined above, the node names must not be ephemeral but on the
same note it's then necessary to clarify when they must be stable
accross migration and when they must be different.

In the above example I'm outlining an image which has the same data but
it's a different image (it was converted for example). In that case the
bitmap migration would imply the same node name, but at the same time
the image is completely different and any other feature may be
incompatible with it.

The same is possible e.g. when you have multiple protocols to access the
same data are they the same thing and thus warrant the same node name?
or are they different.

Treating node names as ephemeral has the advantage of not trying to
assume the equivalence of the images on the migration channel and not
having to try to figure out whether they are "euqivalent enough" for the
given feature.

> 
> - I would like to define a set of default behaviors (when bitmap
> migration is enabled) that migrates only bitmaps it is confident it can
> do so correctly and error out when it cannot.

This requires also defining a set of external constraints when it will
work. Note that they can differ with other features.

> 
> - I'd like to amend the bitmap device name resolution to accommodate the
> drive-mirror case.
> 
> - Acknowledging that there might be cases where the defaults just simply
> aren't powerful enough, allow a manual configuration that allows us to
> select or deselect bitmaps and explicitly set their destination node-name.

This tangentially brings me to another question. In case when the
destination image already contains a bitmap with the same name, will the
migration of bitmaps overwrite it or merge with it?

This is again one thing that should be documented.

In the outlined case of non-shared storage migration libvirt would
obviously prefer merge or having it configurable, but as said, we have
means to work this around by renaming the bitmap temporarily  during
migration and then merging it explicitly.

