Received: from eggs.gnu.org ([2001:4830:134:3::10]:50902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCqdh-0007OY-Hr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCqdd-0007hm-MF
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dCqdd-0007ge-Cc
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:56:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D19751F08
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:56:56 +0000 (UTC)
Date: Mon, 22 May 2017 17:56:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170522165650.GG25655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-6-berrange@redhat.com>
	<b8303243-384c-88a5-b372-c6e3e429e628@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8303243-384c-88a5-b372-c6e3e429e628@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests: add functional test
 validating ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, May 22, 2017 at 11:00:26AM -0500, Eric Blake wrote:
> On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> > The semantics around handling ipv4=on|off & ipv6=on|off are quite
> > subtle to understand in combination with the various hostname addresses
> > and backend types. Introduce a massive test matrix that launches QEMU
> > and validates the ability to connect a client on each protocol as
> > appropriate.
> > 
> > The test requires that the host has ability to bind to both :: and
> > 0.0.0.0, on port 9000. If either protocol is not available, or if
> > something is already listening on that port the test will skip.
> > 
> > Although it isn't using the QTest APIs, it expects the
> > QTEST_QEMU_BINARY env variable to be set.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/.gitignore           |   1 +
> 
> Nice - that often gets forgotten.
> 
> >  tests/Makefile.include     |   4 +
> >  tests/test-sockets-proto.c | 855 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 860 insertions(+)
> >  create mode 100644 tests/test-sockets-proto.c
> 
> 'make check' passed for me with your patches (on a system with both IPv4
> and IPv6 support), so:
> 
> Tested-by: Eric Blake <eblake@redhat.com>
> 
> I did not try what happens on an IPv4-only system, presumably the test
> still behaves sanely there (where sanely may mean skipping rather than
> completing?).

I've not tested either, but I've copied the IPv4/6 protocol detection
code previously used in tests-io-channel-socket, so that should be
safe enough.

> > +++ b/tests/test-sockets-proto.c
> > @@ -0,0 +1,855 @@
> > +/*
> > + * QTest for IPv4/IPv6 protocol setup
> > + *
> > + * Copyright (c) 2017 Red Hat, Inc. and/or its affiliates
> 
> Interesting choice of attribution line.

Copy+paste for the win :-)  I started out copying postcopy-test.c
but eventually deleted all the code.

Seems we have a few of these ususual Red Hat copyright lines
that are probably a candidate to be cleaned up to match the
dominate style.

> > +/*
> > + * This is the giant matrix of combinations we need to consider.
> > + * There are 3 axes we deal with
> > + *
> > + * Axis 1: Protocol flags:
> > + *
> > + *  ipv4=unset, ipv6=unset  -> v4 & v6 clients ([1]
> > + *  ipv4=unset, ipv6=off    -> v4 clients only
> > + *  ipv4=unset, ipv6=on     -> v6 clients only
> > + *  ipv4=off, ipv6=unset    -> v6 clients only
> > + *  ipv4=off, ipv6=off      -> error - can't disable both [2]
> > + *  ipv4=off, ipv6=on       -> v6 clients only
> > + *  ipv4=on, ipv6=unset     -> v4 clients only
> > + *  ipv4=on, ipv6=off       -> v4 clients only
> > + *  ipv4=on, ipv6=on        -> v4 & v6 clients [3]
> > + *
> > + * Depending on the listening address, some of those combinations
> > + * may result in errors. eg ipv4=off,ipv6=on combined with 0.0.0.0
> > + * is nonsensical.
> > + *
> > + * [1] Some backends only support a single socket listener, so
> > + *     will actually only allow v4 clients
> > + * [2] QEMU should fail to startup in this case
> > + * [3] If hostname is "" or "::", then we get a single listener
> > + *     on IPv6 and thus can also accept v4 clients. For all other
> > + *     hostnames, have same problem as [1].
> 
> Makes sense.
> 
> > + *
> > + * Axis 2: Listening address:
> > + *
> > + *  ""        - resolves to 0.0.0.0 and ::, in that order
> > + *  "0.0.0.0" - v4 clients only
> > + *  "::"      - Mostly v6 clients only. Some scenarios should
> > + *              permit v4 clients too.
> 
> Correct.
> 
> > + *
> > + * Axis 3: Backend type:
> > + *
> > + *  Migration - restricted to a single listener. Also relies
> > + *              on buggy inet_parse() which can't accept
> > + *              =off/=on parameters to ipv4/ipv6 flags
> > + *  Chardevs  - restricted to a single listener.
> > + *  VNC       - supports multiple listeners. Also supports
> > + *              socket ranges, so has extra set of tests
> > + *              in the matrix
> 
> And explains the size of the test.  Thankfully it doesn't seem to add
> too much noticeable additional time to 'make check'.

Yeah, since we're not relying on actually running anything for
real we have the most minimal QEMU possible with no devices
beyond whats on the machine type, and we just need QEMU to get
as far as accept'ing network clients before we can then kill
it off. IOW, it'll run the mainloop for a very few iterations
and then get killed.

> 
> > + *
> > + */
> > +static QSocketsData test_data[] = {
> > +    /* Migrate with "" address */
> > +    /* XXX all settings with =off are disabled due to inet_parse() bug */
> > +    /* XXX multilistener bug - should be .ipv6 = 1 */
> 
> Nice that you've pointed out spots for further improvements, and where
> we EXPECT the test to change once we improve the code.

Yes, this is a reminder to myself of what to tackle next :-)

> > +static pid_t run_qemu(const char *args)
> > +{
> > +    const char *pidfile = "test-sockets-proto.pid";
> > +    char *pidstr;
> > +    pid_t child;
> > +    int status;
> > +    pid_t ret;
> > +    const char *binary = getenv("QTEST_QEMU_BINARY");
> > +    long pid;
> > +    if (binary == NULL) {
> > +        g_printerr("Missing QTEST_QEMU_BINARY env variable");
> > +    }
> > +    g_assert(binary != NULL);
> 
> Should we do:
> 
> if (!binary) {
>   message;
>   exit(1);
> }
> 
> instead of relying on g_assert() to do the exit?

Sure.

> 
> > +    /* Now test IPv6 */
> > +    child = run_qemu(data->args);
> > +
> > +    /*
> > +     * The child should always succeed, because its the
> > +     * same config as the succesful run we just did above
> 
> s/succesful/successful/
> 
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    int ret;
> > +    gsize i;
> > +
> > +    if (check_protocol_support() < 0) {
> > +        return 0; /* Skip test if we can't bind */
> 
> We don't have a magic number for skipped tests?  Many projects use exit
> status 77 (rather than 0) to delineate a test that did not fail, but
> whose skip results cannot be used as conclusive evidence of passing.  At
> any rate, you've answered my question earlier - you do behave sanely if
> you cannot test both IPv4 and IPv6 on a given host.

I thought about using status 77, but that doesn't seem to be done in
QEMU unit tests, so I stuck with 0.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
