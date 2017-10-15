Received: from eggs.gnu.org ([2001:4830:134:3::10]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1e3oBk-0007Bn-AA
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1e3oBh-00014e-6e
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:03:04 -0400
Received: from mifritscher.de ([188.40.170.105]:58650
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1e3oBg-00012N-W6
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:03:01 -0400
Message-ID: <693169b0c0e3904c935db314432bf671.squirrel@mifritscher.de>
In-Reply-To: <497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
Date: Sun, 15 Oct 2017 21:02:56 +0200
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

> On 29/09/2017 16:14, Michael Fritscher wrote:
>>> Yes, that's pretty much the only way to do it; it's not the easiest
>>> thing because you have to use NT kernel APIs (NtCreateFile) rather th=
an
>>> e.g. CreateFile.  Likewise for NtQueryAttributesFile,
>>> NtQueryDirectoryObject, etc. NtOpenDirectoryObject. :(
>>>
>>> Paolo
>>>
>> Hi,
>>
>> why do I need the NT* functions instead of the "normal" ones from
>> kernel32? And it was working even with the posix functions some time a=
go
>> (Which I'll port to current qemu atm)
>
> openat lets you create a file from a directory handle and relative path=
.
>  CreateFile doesn't let you do that, only the ntdll functions can.
>
> Paolo
>

Hi,

dumb question: what is the advantage of openat vs. open - only the thing
that someone doesn't need to build the path together by hand?

If I understand the man page of openat correctly, it does _not_ prevent
someone to break out of the jail by using e.g. ../../../blah .
If this assumption is correctly perhaps it is better to avoid using the
*at function family (as it was some time ago) and sanitize the path (by
somehow canonizing it and than check if the beginning is ok).

Then I could use the "normal" posix function again and avoid using the NT=
*
Functions directly which is not soooo nice for various reasons.

Best regards,
Michael Fritscher
