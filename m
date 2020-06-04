Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D518C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571E920738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIG2yd8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571E920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmB5-0003CI-M2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgmAU-0002ki-Jv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:28:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24490
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgmAT-0000EN-M8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591262888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=na+V568HkWblpN3L3G9ltPEjZlT3GOY9hJjizZIFvYk=;
 b=RIG2yd8QxipHDzdNV6CBCmKFKBbI3ftvdTzfc5DspjnyMGB9k1s/CqxyHEzKxKmA0YitoP
 sW4YA4wblwmlxcC2jA1/P/NozSbNFsFEG0nMKgDl4y8DWyH+BihjfnuwJSBW3uf0uNuFhS
 qJMh5SOUWa53XtYQe2iCVfnu4WKUiPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-ACSDMx5fOgaNYfDjiEqu_A-1; Thu, 04 Jun 2020 05:28:06 -0400
X-MC-Unique: ACSDMx5fOgaNYfDjiEqu_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD34188360C;
 Thu,  4 Jun 2020 09:28:06 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC19D19D71;
 Thu,  4 Jun 2020 09:28:01 +0000 (UTC)
Date: Thu, 4 Jun 2020 10:27:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: About improving devices and renaming migration stream...
Message-ID: <20200604092759.GA2851@work-vm>
References: <b24c8f81-703c-16c2-94e9-e485962eca42@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b24c8f81-703c-16c2-94e9-e485962eca42@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> Hello Dave,
> 
> ==[background]==
> 
> I've been doing this pflash rework:
> 
> * Add abstract TYPE_NOR_FLASH
> 
>   - qdev type
>   - blockdev backend
>   - manage bank/sector,
>   - manage timer for erase/write delays
>   - can be used by I2C/SPI NOR flash too
> 
> * Add abstract TYPE_PARALLEL_NOR_FLASH
> 
>   - mostly SysBusDevice bindings
> 
> * Add TYPE_COMMON_FLASH_MEMORY_INTERFACE
> 
>   - common CFI code
>   - abstracts CFI methods
> 
> * Refactor TYPE_PFLASH_CFI02
>   -> TYPE_PARALLEL_NOR_CFI02_FLASH
> 
>   - Inherit TYPE_NOR_FLASH -> TYPE_PARALLEL_NOR_FLASH
>   - Implements TYPE_COMMON_FLASH_MEMORY_INTERFACE
> 
> 
> I kept the harder for the end... (maybe bad idea):
>   - migration
>   - CFI01
> 
> 
> ==[problems]==
> 
> 
> 1/ Can I change the name of a migration stream?
> 
> I want to add migration from old TYPE_PFLASH_CFI02 to
> TYPE_PARALLEL_NOR_CFI02_FLASH, and deprecate TYPE_PFLASH_CFI02.
> 
> From docs/devel/migration.rst:
> 
>   "The ``ID string`` is normally unique, having been
>    formed from a bus name and device address, PCI devices
>    and storage devices hung off PCI controllers fit this
>    pattern well.  Some devices are fixed single instances
>    (e.g. "pc-ram").
>    Others (especially either older devices or system devices
>    which for some reason don't have a bus concept) make use
>    of the ``instance id`` for otherwise identically named
>    devices."
> 
> I started TYPE_PARALLEL_NOR_CFI02_FLASH from a clean design,
> I'm not sure I can redo everything keeping the same type name.
> 
> Is it possible to use massaging functions to migrate from
> TYPE_A (version y) to TYPE_B (version x)?

There's normally a way to fudge it.
Most devices use a path rather than the class; so the type is irrelevant.
When they use the type then you can register a device with the old name
to read the old migration stream.  There's no check during migration
loading that every device receives a stream, so if your old device hook
receives it and the new one doesn't that may work.

Having said all that, I'm struggling to find any migration entries in
pflash_cfi02 - I tried a ppc405 'taihu' device and that doesn't seem to
have anything for the pflash_cfi02 other than the RAM section.

A q35 pflash though does land in the stream as pflash_cfi01 I think with
instance id's to separate 2 devices (which is pretty horrid!).

> 2/ Do I need to care about backward compatibility?
> 
> I understand we want to migrate from old -> new QEMU version.
> 
> From docs/devel/migration.rst:
> 
>   "In general QEMU tries to maintain forward migration
>    compatibility (i.e. migrating from QEMU n->n+1) and
>    there are users who benefit from backward
>    compatibility as well."
> 
> When is it important to migrate from new -> old?

Downgrade does get used in clusters of hosts; imagine you've got 'n'
machines, most of which are running VMs, managed by something that
migrates VMs between them; maybe for load balancing or maybe for dealing
with failures etc.  Now, it's time to upgrade - so you take one machine,
migrate everything off it, upgrade that machine, and add it back into
the cluster;  VMs get started on it or migrated to it (forward
migration).  If you need to take this host down for any reason, or
load balance, you require backward migration to move those VMs
to an older host.
In a small installation with a few hosts you might get away with it
by having enough spare hosts to upgrade - but if it's say a 3 host setup
then you've not got much room.
In a big installation it can be tricky for the opposite reason; you end
up with effectively 2 separate clusters until everything is upgraded.

People tend to care less about backwards migration for emulation
uses rather than cluster uses.

> Can this be a blocker?

For some machines yes; downstream we (RH) support some combination of
backwards migration - so someone would have to make it work.

> Am I doomed to keep the old device forever?

The back compatibility can get deprecated at some point; determining
'when' comes down to when no one cares about it any longer, and that's
based on when people have supported installations of clusters using
the old version, which is tricky to tell.

> Is this what are versioned machines for?
> I.e. adding machine-v6 that start with the newer devices,
> breaking backward compat.

Yes, that's one use for it; machine types do double-duty; they provide
a way to switch the guest view of a device/machine, but they also
provide the way to switch a migration stream incompatibility.

Dave


> Thanks,
> 
> Phil.
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


