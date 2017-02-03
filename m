Received: from eggs.gnu.org ([2001:4830:134:3::10]:56438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZeJJ-0005oC-IA
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZeJI-0006Ds-MY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:53:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170203123754.GC1528@andariel.pipo.sk>
Date: Fri, 03 Feb 2017 14:53:48 +0100
In-Reply-To: <20170203123754.GC1528@andariel.pipo.sk> (Peter Krempa's message
	of "Fri, 3 Feb 2017 13:37:54 +0100")
Message-ID: <87inorl6s3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Peter Krempa <pkrempa@redhat.com> writes:

> On Thu, Feb 02, 2017 at 20:42:33 +0100, Markus Armbruster wrote:
>
> [...]
>
>> === Comparison ===
>> 
>> In my opinion, dotted keys are weird and ugly, but at least they don't
>> add to the quoting mess.  Structured values look better, except when
>> they do add to the quoting mess.
>
> From libvirt's point of view anything that can be easily generated from
> the JSON representation into command line arguments is acceptable.
> Neither uglyness, nor escaping worry us that much. Libvirt users usually
> don't come into contact with the command line and if they do it's messy
> anyways.

Generating JSON should be pretty much as simple as it gets then.

Even quoting for shell is easy: enclose in "'", taking care to quote "'"
in the JSON text.  Since "'" can only occur in JSON strings, you can
simply replace it by \u0027.  Of course you can also replace by '"'"',
trading legibility for not having to exploit "can only occur in
strings".

>> I'm having a hard time deciding which one I like less :)
>
> I don't like plain JSON. On the other hand I like the dotted syntax ...
> mostly as I've already written the convertors for it a while ago :) [1]

Heh!

I'd certainly go with JSON once that works, to minimize differences with
QMP, execute less code (= fewer bugs), and because I find it more
legible than dotted keys.

> Currently we already to that with anything '-object' related that we do
> in libvirt (memory backing objects, master encryption key, etc) and for
> a few certain network disk backing protocols:
>
> I stole this example above:
>
> We already generate this internally:
>     '{ "file": {
>        "driver": "gluster", "volume": "testvol",
>        "path": "/path/a.qcow2", "debug": 9,
>        "server": [ { "type": "tcp",
>                      "host": "1.2.3.4", "port": "24007"},
>                    { "type": "unix",
>                      "socket": "/var/run/glusterd.socket" } ] } }'
>
> And convert it to this:
>>     -drive driver=qcow2,file.driver=gluster,
>>            file.volume=testvol,file.path=/path/a.qcow2,file.debug=9,
>>            file.server.0.type=tcp,
>>            file.server.0.host=1.2.3.4,
>>            file.server.0.port=24007,
>>            file.server.1.type=unix,
>>            file.server.1.socket=/var/run/glusterd.socket
>
> There are unfortunately two implementations of the array generator:
> For -object we use the repeated key method, and for gluster we use the
> numbered method. It might be due to the fact that I tried to do bitmap
> to array conversion, where the bitmap is represented by a list of
> ranges. It was necessary for memory hotplug

Two array generators isn't so bad considering we have three and a half
ways to do arrays/lists with QemuOpts.

> [1] 331b2583ec2928b in libvirt introduces the first generator (2015/01)
>     b7eef33df20dc19 adds the numbered array methot so that it can be
>                     uset with gluster (2016/07)
