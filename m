Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C958C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F57206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgMj3uoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F57206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3ey-0002lw-1N
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kD3dd-0001aQ-AY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kD3da-00019L-G3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598956537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NAY2/a4Y2AatabFuDDgQnzty8VmSqaLTTQonY/KTgS0=;
 b=MgMj3uohXEI1jNim4JsPzMPmSlXh4sfGhPtq6fzXzTVA3XF10ICRQ6/MdHGa/MdCNkortd
 lhRzzEFJ3E1erL8V6+BPajDc817sEzIHEQkaW3mNfdHIE7rvWDOCeW5J5/2mBOM1LU48XD
 R6RdNWuFz6VnOG2EQkxjjLa7CUPEWRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-NLPAEgT5PKKjwhfiij6cDw-1; Tue, 01 Sep 2020 06:35:33 -0400
X-MC-Unique: NLPAEgT5PKKjwhfiij6cDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAAC6425CF;
 Tue,  1 Sep 2020 10:35:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A04BC5C1A3;
 Tue,  1 Sep 2020 10:35:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07A8E113C418; Tue,  1 Sep 2020 12:35:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com> <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com> <20200511154645.GI2811@work-vm>
 <20200512113206.62836e44@luklap> <20200512094337.GK1191162@redhat.com>
 <20200513103245.GD6202@linux.fritz.box>
 <20200513105359.GF3225@work-vm>
 <20200513111320.GE6202@linux.fritz.box>
Date: Tue, 01 Sep 2020 12:35:28 +0200
In-Reply-To: <20200513111320.GE6202@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 13 May 2020 13:13:20 +0200")
Message-ID: <87blip3hu7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Lukas Straub <lukasstraub2@web.de>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 13.05.2020 um 12:53 hat Dr. David Alan Gilbert geschrieben:
>> * Kevin Wolf (kwolf@redhat.com) wrote:
>> > Am 12.05.2020 um 11:43 hat Daniel P. Berrang=C3=83=C6=92=C3=82=C2=A9 g=
eschrieben:
>> > > On Tue, May 12, 2020 at 11:32:06AM +0200, Lukas Straub wrote:
>> > > > On Mon, 11 May 2020 16:46:45 +0100
>> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> > > >=20
>> > > > > * Daniel P. Berrang=C3=83=C6=92=C3=86=E2=80=99=C3=83=E2=80=9A=C3=
=82=C2=A9 (berrange@redhat.com) wrote:=20
>> > > > > > ...
>> > > > > > That way if QEMU does get stuck, you can start by tearing down=
 the
>> > > > > > least distruptive channel. eg try tearing down the migration c=
onnection
>> > > > > > first (which shouldn't negatively impact the guest), and only =
if that
>> > > > > > doesn't work then, move on to tear down the NBD connection (wh=
ich risks
>> > > > > > data loss) =20
>> > > > >=20
>> > > > > I wonder if a different way would be to make all network connect=
ions
>> > > > > register with yank, but then make yank take a list of connection=
s to
>> > > > > shutdown(2).
>> > > >=20
>> > > > Good Idea. We could name the connections (/yank callbacks) in the
>> > > > form "nbd:<node-name>", "chardev:<chardev-name>" and "migration"
>> > > > (and add "netdev:...", etc. in the future). Then make yank take a
>> > > > list of connection names as you suggest and silently ignore connec=
tions
>> > > > that don't exist. And maybe even add a 'query-yank' oob command re=
turning
>> > > > a list of registered connections so the management application can=
 do
>> > > > pattern matching if it wants.
[...]
>> > > Yes, that would make the yank command much more flexible in how it c=
an
>> > > be used.
>> > >=20
>> > > As an alternative to using formatted strings like this, it could be
>> > > modelled more explicitly in QAPI
>> > >=20
>> > >   { 'struct':  'YankChannels',
>> > >     'data': { 'chardev': [ 'string' ],
>> > >               'nbd': ['string'],
>> > > =09      'migration': bool } }
>> > >=20
>> > > In this example, 'chardev' would accept a list of chardev IDs which
>> > > have it enabled, 'nbd' would accept a list of block node IDs which
>> > > have it enabled, and migration is a singleton on/off.
>> >=20
>> > Of course, it also means that the yank code needs to know about every
>> > single object that supports the operation, whereas if you only have
>> > strings, the objects could keep registering their connection with a
>> > generic function like yank_register_function() in this version.
>> >=20
>> > I'm not sure if the additional complexity is worth the benefits.
>>=20
>> I tend to agree; although we do have to ensure we either use an existing
>> naming scheme (e.g. QOM object names?) or make sure we've got a well
>> defined list of prefixes.
>
> Not everything that has a network connection is a QOM object (in fact,
> neither migration nor chardev nor nbd are QOM objects).
>
> I guess it would be nice to have a single namespace for everything in
> QEMU, but the reality is that we have a few separate ones. As long as we
> consistently add a prefix that identifies the namespace in question, I
> think that would work.
>
> This means that if we're using node-name to identify the NBD connection,
> the namespace should be 'block' rather than 'nbd'.
>
> One more thing to consider is, what if a single object has multiple
> connections? In the case of node-names, we have a limited set of allowed
> characters, so we can use one of the remaining characters as a separator
> and then suffix a counter. In other places, the identifier isn't
> restricted, so suffixing doesn't work. Maybe prefixing does, but it
> would have to be there from the beginning then.

If I understand it correctly, the argument for encoding the structured
"what to yank" information into a string is ease of implementation.  The
yank core sees only strings, and doesn't care about their contents.
Code registering "yankables" can build strings however it likes, as long
as they're all distinct.  QMP clients need to understand how the strings
are built to be able to yank specific "yankables" (as opposed to blindly
yanking stuff until QEMU gets unstuck").

I disagree with this argument for a number of reasons.

1. Use of strings doesn't reduce complexity, it moves it.

   String:

   * QMP clients may need to parse the strings they get back from
     command query-yank intro structured data.

   * QMP clients may need to format structured data into a string for
     command yank.

   * How structured data is be parsed from / formatted to a string is
     part of the external interface, and needs to be documented, in
     addition to the data structure.

   * The strings need to be kept backward compatible.  We could
     inadvertently create problems like the one you described above,
     where a format like UNIQUE-PREFIX:ID with an unrestricted ID is not
     extensible.

   * Code providing "yankables" needs to somehow ensure their strings
     are distinct.

   Complex type:

   * The result of query-yank is already structured data, no need for
     QMP clients to parse.

   * The argument of yank is structured data, no need to for QMP clients
     to format it into a string first.

   * Documenting just the data structure suffices.

   * Backward compatibility of complex QMP types is a well-understood
     problem.

   * Defining the structure in the QAPI schema as union trivially
     ensures the union branches are distinct.

2. Even with structured yank arguments, the yank core doesn't *need* to
   understand the structure.

   The yank core manages a set of instances.  Each instance associates a
   key with a list of YankFuncAndParam.  This is a basically dictionary.
   All the yank core needs to do with the dictionary keys is looking
   them up.

   The proposed implementation uses a list of instances (which is just
   fine).  All the lookup needs from the keys is an "is equal" relation.

   Checking two QAPI objects for structural equality is admittedly not
   as simple as comparing strings.  It does not, however, require
   understanding their structure.  Two stupid solutions come to mind:

   * Hand-written compare that keeps specifics out of the yank core

     Whatever uses a variant of YankInstance gets to provide a
     comparison function of the variant members.

     Compare the common members (initially just @type, which is the
     discriminator).  Return false if any of them differs.

     Else both instances use the same variant.  Return the value of the
     variant comparison function.

   * Visitors exist

     Convert both YankInstances to QObject, compare with
     qobject_is_equal(), done.

3. In QMP, encoding structured data in strings is anathema :)

[...]


