Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1exsqR-00056H-H7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1exsqN-0001or-MG
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:20:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1exsqN-0001ng-GL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:20:47 -0400
Date: Mon, 19 Mar 2018 11:20:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180319112032.GC3151@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA9u3s=qZWN0Q1irqNu8cpHvBf2p4MsstaAaq-nbNLq1_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9u3s=qZWN0Q1irqNu8cpHvBf2p4MsstaAaq-nbNLq1_A@mail.gmail.com>
Subject: Re: [Qemu-devel] qapi escape-too-big test doesn't work if LANG=C ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Mon, Mar 19, 2018 at 10:37:12AM +0000, Peter Maydell wrote:
> I recently tweaked my build scripts to run with LANG=C (trying
> to suppress gcc's irritating habit of using smartquotes rather
> than plain old ''). This seems to result in an error running
> the qapi-schema/escape-too-big test:
> 
> PYTHONPATH=/home/petmay01/linaro/qemu-for-merges/scripts python3 -B
> /home/petmay01/linaro/qemu-for-merges/tests/qapi-schema/test-qapi.py
> /home/petmay01/linaro/qemu-for-merges/tests/qapi-schema/escape-too-big.json
> >tests/qapi-schema/escape-too-big.test.out
> 2>tests/qapi-schema/escape-too-big.test.err; echo $?
> >tests/qapi-schema/escape-too-big.test.exit
> 1c1,10
> < tests/qapi-schema/escape-too-big.json:3:14: For now, \u escape only
> supports non-zero values up to \u007f
> ---
> > Traceback (most recent call last):
> >   File "tests/qapi-schema/test-qapi.py", line 64, in <module>
> >     schema = QAPISchema(sys.argv[1])
> >   File "scripts/qapi/common.py", line 1492, in __init__
> >     parser = QAPISchemaParser(open(fname, 'r'))
> >   File "scripts/qapi/common.py", line 264, in __init__
> >     self.src = fp.read()
> >   File "/usr/lib/python3.5/encodings/ascii.py", line 26, in decode
> >     return codecs.ascii_decode(input, self.errors)[0]
> > UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 61: ordinal not in range(128)
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:927:
> recipe for target 'check-tests/qapi-schema/escape-too-big.json' failed

So your "C" locale will be non-UTF-8, except on OS-X where the "C" locale
is UTF-8 by default.

Unfortunately while POSIX expects the "C" locale to be 8-bit cleanup,
Python by default will reject any characters outside the 7-bit range
with its "ascii" codec. So this is ultimately a python bug, but there's
little we can do about that given how widely deployed the bug is.

To workaround this problem in other applications what I have done is
add the following to Makefiles before invoking python:

    LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8 

The LC_ALL= bit is needed because if the user has set LC_ALL themselves
it will override LANG and all other LC_* variables. Setting LANG=C is
not strictly needed, as LC_CTYPE will override it.

CC'ing Eric since he was involved in the discussions about this bug
in other libvirt related apps.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
