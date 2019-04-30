Received: from eggs.gnu.org ([209.51.188.92]:45610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLSfP-0004eB-Ez
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLSfO-0004nr-1s
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLSfN-0004nC-Pi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:19:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 186878764B
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 13:19:25 +0000 (UTC)
Date: Tue, 30 Apr 2019 14:19:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190430131919.GN6818@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] QMP; unsigned 64-bit ints; JSON standards compliance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>

The QEMU  QMP service is based on JSON which is nice because that is a
widely supported "standard" data format.....

....except QEMU's implementation (and indeed most impls) are not strictly
standards compliant.

Specifically the problem is around representing 64-bit integers, whether
signed or unsigned.

The JSON standard declares that largest integer is 2^53-1 and the
likewise the smallest is -(2^53-1):

  http://www.ecma-international.org/ecma-262/6.0/index.html#sec-number.max_safe_integer

A crazy limit inherited from its javascript origins IIUC.

QEMU, and indeed many applications, want to handle 64-bit integers.
The C JSON library impls have traditionally mapped integers to the
data type 'long long int' which gives a min/max of  -(2^63) / 2^63-1.

QEMU however /really/ needs 64-bit unsigned integers, ie a max 2^64-1.

Libvirt has historically used the YAJL library which uses 'long long int'
and thus can't officially go beyond 2^63-1 values. Fortunately it lets
libvirt get at the raw json string, so libvirt can re-parse the value
to get an 'unsigned long long'.

We recently tried to switch to Jansson because YAJL has a dead upstream
for many years and countless unanswered bugs & patches. Unfortunately we
forgot about this need for 2^64-1 max, and Jansson also uses 'long long int'
and raises a fatal parse error for unsigned 64-bit values above 2^63-1. It
also provides no backdoor for libvirt todo its own integer parsing. Thus
we had to abort our switch to jansson as it broke parsing QEMU's JSON:

  https://bugzilla.redhat.com/show_bug.cgi?id=1614569

Other JSON libraries we've investigated have similar problems. I imagine
the same may well be true of non-C based JOSN impls, though I've not
investigated in any detail.

Essentially libvirt is stuck with either using the dead YAJL library
forever, or writing its own JSON parser (most likely copying QEMU's
JSON code into libvirt's git).

This feels like a very unappealing situation to be in as not being
able to use a JSON library of our choice is loosing one of the key
benefits of using a standard data format.

Thus I'd like to see a solution to this to allow QMP to be reliably
consumed by any JSON library that exists.

I can think of some options:

  1. Encode unsigned 64-bit integers as signed 64-bit integers.

     This follows the example that most C libraries map JSON ints
     to 'long long int'. This is still relying on undefined
     behaviour as apps don't need to support > 2^53-1.

     Apps would need to cast back to 'unsigned long long' for
     those QMP fields they know are supposed to be unsigned.


  2. Encode all 64-bit integers as a pair of 32-bit integers.
    
     This is fully compliant with the JSON spec as each half
     is fully within the declared limits. App has to split or
     assemble the 2 pieces from/to a signed/unsigned 64-bit
     int as needed.


  3. Encode all 64-bit integers as strings

     The application has todo all parsing/formatting client
     side.


None of these changes are backwards compatible, so I doubt we could make
the change transparently in QMP.  Instead we would have to have a
QMP greeting message capability where the client can request enablement
of the enhanced integer handling.

Any of the three options above would likely work for libvirt, but I
would have a slight preference for either 2 or 3, so that we become
100% standards compliant.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
