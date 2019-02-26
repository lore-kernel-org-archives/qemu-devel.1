Received: from eggs.gnu.org ([209.51.188.92]:55823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyX5J-0005U5-Ci
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyX5H-00081K-Ax
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gyX5H-0007xh-2U
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:23:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12B22307D8E3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 07:23:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225170646.GH379@stefanha-x1.localdomain>
Date: Tue, 26 Feb 2019 08:23:17 +0100
In-Reply-To: <20190225170646.GH379@stefanha-x1.localdomain> (Stefan Hajnoczi's
	message of "Mon, 25 Feb 2019 17:06:46 +0000")
Message-ID: <87r2bvm2sa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, Feb 25, 2019 at 09:50:26AM +0100, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> 
>> > QMP clients can usually detect the presence of features via schema
>> > introspection.  There are rare features that do not involve schema
>> > changes and are therefore impossible to detect with schema
>> > introspection.
>> >
>> > This patch adds the query-qemu-capabilities command.  It returns a list
>> > of capabilities that this QEMU supports.
>> 
>> The name "capabilities" could be confusing, because we already have QMP
>> capabilities, complete with command qmp_capabilities.  Would "features"
>> work?
>
> Sure, will fix.
>
>> > The decision to make this a command rather than something statically
>> > defined in the schema is intentional.  It allows QEMU to decide which
>> > capabilities are available at runtime, if necessary.
>> >
>> > This new interface is necessary so that QMP clients can discover that
>> > migrating disk image files is safe with cache.direct=off on Linux.
>> > There is no other way to detect whether or not QEMU supports this.
>> 
>> I think what's unsaid here is that we don't want to make a completely
>> arbitrary schema change just to carry this bit of information.  We
>> could, but we don't want to.  Correct?
>
> Yes, exactly.

Then let's rephrase a little:

     QMP clients can usually detect the presence of features via schema
     introspection.  There are rare features that do not involve schema
     changes.  To make them detectable with schema introspection, we'd
     have to make some arbitrary schema change.  Annoying.

     The new query-qemu-features command lets us avoid that.  It returns
     a list of features supported by this QEMU.

     The decision to make this a command rather than something statically
     defined in the schema is intentional.  It allows QEMU to decide which
     capabilities are available at runtime, if necessary.

     Use the new command to declare migrating disk image files is safe
     with cache.direct=off on Linux.

[...]
