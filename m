Received: from eggs.gnu.org ([2001:4830:134:3::10]:59155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8R67-0003WM-3h
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8R63-0005Ir-1N
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:56:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8R62-0005Ih-S4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 155294075A7D
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 13:56:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
Date: Tue, 17 Apr 2018 15:56:25 +0200
In-Reply-To: <7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com> (Eric Blake's
	message of "Mon, 12 Mar 2018 07:18:08 -0500")
Message-ID: <87efjeaqd2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 03/12/2018 04:07 AM, Paolo Bonzini wrote:
>> On 12/03/2018 08:27, Thomas Huth wrote:
>>> "-net" is clearly a legacy option. Yet we still use it in almost all
>>> examples in the qemu documentation, and many other spots in the network
>>> chapter. We should make it less prominent that users are not lured into
>>> using it so often anymore. So instead of starting the network chapter with
>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>>> everywhere, all the "-net" related documentation is now moved to the end
>>> of the chapter. The new "--nic" option is moved to the beginning of the
>>> chapter instead, with a new example that should demonstrate how "--nic"
>>> can be used to shortcut "--device" with "--netdev". The examples in this
>>> chapter are changed to use the "--device" and "--netdev" options or
>>> "--nic" instead of "-net nic -net <backend>".
>>>
>>> While we're at it, also remove a legacy remark about very old Linux
>>> distributions. Also remove the "[...]" from the examples in this chapter
>>> since we are not using this ellipsis in any other examples in our docu-
>>> mentation.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2:
>>>   - Fixed the bad "--device=e1000" example
>>
>> Frankly I think this is the proof that double-dash option names are a
>> bad idea.  The reason to do that was to make qemu-img and qemu command
>> lines more similar in the documentation, but the truth is they are not
>> similar and shouldn't be made similar.  The equal sign is one example,
>> where qemu-img supports "--format=raw" but QEMU doesn't support
>> "--device=e1000", but it's not the only one.
>
> Our hand-rolled parser sucks.  We should fix it to be more like
> getopt, at which point --device=e1000 would work.
>
>>
>> qemu-img supports things such as "-fraw", qemu doesn't---for example
>> "-m1024" doesn't work).
>
> Our hand-rolled parser sucks.  We should fix it to be more like
> getopt, at which point -m1024 would work.
>
>>  qemu-img can combine single-letter options
>> (e.g. "qemu-img convert -pc") but qemu cannot---e.g. "-sm" doesn't
>> combine "-s" and "-m".
>
> That's a legitimate difference between getopt_long() and
> getopt_long_only() - but to some extent, even getopt_long_only() can
> bundle unambiguous short options correctly.  Again, fixing our
> hand-rolled parser to use getopt_long_only() might make this better.
>
>> No need to drop them in QEMU, since it's more or less just a convenience
>> for people that are used to double-dash long options, but using them in
>> the documentation is confusing.
>
> For -object vs. --object (which IS used identically between qemu-img
> and qemu proper), we really do want to favor a common spelling (which
> perhaps means we need to first fix our hand-rolled parser to not suck
> so much - possibly by rewriting it to use getopt_long_only()).  For
> options like -nic vs. --nic, which have no (current) counterpart in
> qemu-img, it's a harder sell (as you continue to argue), but Dan's
> original suggestion to prefer double-dash in the documentation was
> because consistency helps (and if that means improving our parser to
> behave more consistently, that's a good thing).

For what it's worth, my "[RFC PATCH 00/32] Command line QAPIfication"
replaces the original parsing art by getopt_long_only().

Completing that work will take some time, but once it's done, we can
(and I think we should) prefer double-dash for consistency.
