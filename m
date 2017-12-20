Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRiuR-00069n-Fs
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRiuQ-0000jK-G5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:16:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<20171220111133.GR21216@redhat.com>
Date: Wed, 20 Dec 2017 19:15:55 +0100
In-Reply-To: <20171220111133.GR21216@redhat.com> (Daniel P. Berrange's message
	of "Wed, 20 Dec 2017 11:11:33 +0000")
Message-ID: <87ind16zac.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Raw notes from a small block layer/QAPI/something
 pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Fri, Dec 15, 2017 at 05:38:00PM +0100, Max Reitz wrote:
>
>> Image creation in qemu-system-* vs. qemu-img:
>>   In order to get proper introspection for qemu-img create, we need a
>>   QAPI schema.  If we have a QAPI schema, we might as well add
>>   blockdev-create to QMP.
>>   As long as we do not have a really-none (null, void, ...) machine type
>>   for qemu-system-*, launching such a process just for creating an image
>>   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
>>   However, as for libvirt, this is not exactly a regression since
>>   libvirt currently cannot create images at all (apart from implicitly
>>   through drive-mirror etc.).  Further work on voidifying qemu-system-*
>>   will improve performance.
>
> In terms of the I/O operations involved, image creation is a already a
> pretty slow process, particularly if pre-allocation is used which is
> common.  So even QEMU's current slow (circa 300ms) startup time is a
> complete non-issue for image creation IMHO - it'll be dwarfed by the
> time to actually create the image. 
>
>>   On the other side, we can also add QAPI introspection to qemu-img.
>>   (qemu-img already links to QAPI, so this should not be too hard.)
>>   qemu-img will also need command-line introspection, though.
>
> I figure the qapi-ificiation is the hard & time consuming bit of
> work. Once that's done exporting it via both qemu-img & qemu-system*
> is quite straighforward.

qemu-system-*: trivial.
qemu-img, via command line: straightforward
qemu-img, via QMP: more difficult, since QMP is entangled with HMP,
    character devices, ...

If libvirt really wants to use QMP for the job, *and* doesn't want to
use the qemu-system-* that's running a guest, the easy solution is
running another qemu-system-* without a guest.

>>   Plan B:
>>     libvirt can use qemu-img now with the currently supported options,
>>     and as soon as libvirt needs anything better, we will have something
>>     better done.
>>     (Also, there is "qemu-img create -f $format -o help"!  Because
>>      parsing help texts has worked so well in the past.)
>
> Regards,
> Daniel
