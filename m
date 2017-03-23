Received: from eggs.gnu.org ([2001:4830:134:3::10]:50586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr245-0005T3-T1
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr242-0004nR-0Q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:42:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-2-f4bug@amsat.org>
	<87y3vw1o94.fsf@dusky.pond.sub.org>
	<1490255007.463.11.camel@redhat.com>
	<CAJ+F1CJNy+e83EHR_8uzAHURxDk6idnNTTL_FoD-krWPue7Lww@mail.gmail.com>
	<1490262680.463.27.camel@redhat.com>
Date: Thu, 23 Mar 2017 13:41:52 +0100
In-Reply-To: <1490262680.463.27.camel@redhat.com> (Gerd Hoffmann's message of
	"Thu, 23 Mar 2017 10:51:20 +0100")
Message-ID: <87tw6ktban.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RESEND 1/3] usb-ccid: make
 ccid_write_data_block() cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>>  oops, there are hard-coded calls with NULL/0. I suppose to fix clang
>> warning, it would need to check if data != null for memcpy.
>
> I'd check for len > 0, and in that if branch we can also assert on data
> == NULL and thereby check that len and data are consistent.

If len is non-zero but data is null, memcpy() will crash just fine by
itself, so why bother asserting.  If len is zero, there's nothing to
assert.

I'd simply protect memcpy() with if (len) and call it a day.
