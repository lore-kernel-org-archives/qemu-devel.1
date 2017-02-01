Received: from eggs.gnu.org ([2001:4830:134:3::10]:55078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cYk9G-0006GX-JV
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cYk9F-00086O-LZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:55:50 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cYk9F-00085v-Gd
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:55:49 -0500
Received: by mail-io0-x244.google.com with SMTP id 101so19627013iom.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:55:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAo6VWNMw2GdR-MznT5np7ov+hSGZZ-6t69bm5+TqAjmHZJZPQ@mail.gmail.com>
References: <20161114180359.GA24217@lemon>
	<ff56438b-d75f-eb5a-c398-9ce1b20c2f40@redhat.com>
	<20161115020405.GB9226@lemon>
	<20161115101850.GA4836@stefanha-x1.localdomain>
	<20161115124417.GC9226@lemon>
	<20161115144551.GB17672@stefanha-x1.localdomain>
	<20161115150016.GD9226@lemon>
	<20161115192026.GA26428@stefanha-x1.localdomain>
	<CAAo6VWN9uO9-jjEfHxLHCBE5V5tr5Sx52tGY5vu3g8JgcCRqvQ@mail.gmail.com>
	<87eg2bokx0.fsf@dusky.pond.sub.org> <20161116094901.GA31999@lemon>
	<CAJSP0QWvsO8480gsOa=1jiY-8WLwTt6cgPtP6O-CAOfehZab3A@mail.gmail.com>
	<CAAo6VWNMw2GdR-MznT5np7ov+hSGZZ-6t69bm5+TqAjmHZJZPQ@mail.gmail.com>
From: ashish mittal <ashmit602@gmail.com>
Date: Tue, 31 Jan 2017 17:55:47 -0800
Message-ID: <CAAo6VWM26xdQhjX9YGiPAXBBxzUNwSi+AUohWyO1HEXxfPv+LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Ashish Mittal <ashish.mittal@veritas.com>, Jeff Cody <jcody@redhat.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, John Ferlan <jferlan@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Peter Krempa <pkrempa@redhat.com>

Hi,

There has been some work going on on the VxHS libvirt patches and we
are making good progress.

A suggestion has been made on the libvirt community to check if we can
change the qemu VxHS device specification syntax as follows.

Replace

(a) +file.server.host=192.168.0.1,file.server.port=9999

with

(b) +file.host=192.168.0.1,file.port=9999

The reasoning being that since we have only one host (true as the
failover is now being handled completely/transparently) within the
libqnio library), the "server" part is redundant.

Excerpt from John Ferlan's email -
/======================================/
#2. Is the desire to ever support more than 1 host? If not, then is the
"server" syntax you've borrowed from the Gluster code necessary? Could
you just go with the single "host" like NBD and SSH. As it relates to
the qemu command line - I'm not quite as clear. From the example I see
in commit id '7b7da9e28', the gluster syntax would have:

+file.server.0.type=tcp,file.server.0.host=example.org,file.server.0.port=6000,\
+file.server.1.type=tcp,file.server.1.host=example.org,file.server.1.port=24007,\
+file.server.2.type=unix,file.server.2.socket=/path/to/sock,format=qcow2,\

whereas, the VxHS syntax is:
 +file.server.host=192.168.0.1,file.server.port=9999,format=raw,if=none,\

FWIW: I also note there is no ".type=tcp" in your output - so perhaps
the "default" is tcp unless otherwise specified, but I'm sure of the
qemu syntax requirements in this area. I assume that since there's only
1 server, the ".0, .1, .2" become unnecessary (something added by commit
id 'f1bbc7df4' for multiple gluster hosts).

I haven't closedly followed the qemu syntax discussion, but it would it
would be possible to use:

+file.host=192.168.0.1,file.port=9999

Similar to how NBD (see commit id 'a1674fd9') and SSH (see commit id
'bc225b1b5') are handled.
/======================================/

If this proposal looks OK to the community, then I will make this user
interface change in the next VxHS qemu patch.

Thanks,
Ashish

On Wed, Nov 16, 2016 at 9:05 AM, ashish mittal <ashmit602@gmail.com> wrote:
> On Wed, Nov 16, 2016 at 3:27 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Wed, Nov 16, 2016 at 9:49 AM, Fam Zheng <famz@redhat.com> wrote:
>>> On Wed, 11/16 10:04, Markus Armbruster wrote:
>>>> ashish mittal <ashmit602@gmail.com> writes:
>>>>
>>>> > Thanks for concluding on this.
>>>> >
>>>> > I will rearrange the qnio_api.h header accordingly as follows:
>>>> >
>>>> > +#include "qemu/osdep.h"
>>>>
>>>> Headers should not include osdep.h.
>>>
>>> This is about including "osdep.h" _and_ "qnio_api.h" in block/vxhs.c, so what
>>> Ashish means looks good to me.
>>
>> Yes, I think "will rearrange the qnio_api.h header" was a typo and was
>> supposed to be block/vxhs.c.
>>
>> Stefan
>
> Thanks for the correction. Yes, i meant rearrange headers in block/vxhs.c.
