Received: from eggs.gnu.org ([2001:4830:134:3::10]:34762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cfmFB-00059r-EW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cfmFA-0002QC-6d
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:35:01 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cfmFA-0002Px-20
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:35:00 -0500
Received: by mail-it0-x243.google.com with SMTP id w185so4474203ita.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:34:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170220110235.GD21255@stefanha-x1.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Mon, 20 Feb 2017 03:34:57 -0800
Message-ID: <CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
>> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
>>
>>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
>>     > Hi,
>>     >
>>     > I am getting the following error with checkpatch.pl
>>     >
>>     > ERROR: externs should be avoided in .c files
>>     > #78: FILE: block/vxhs.c:28:
>>     > +QemuUUID qemu_uuid __attribute__ ((weak));
>>     >
>>     > Is there any way to get around this, or does it mean that I would have
>>     > to add a vxhs.h just for this one entry?
>>     >
>>
>>     I remain skeptical on the use of the qemu_uuid as a way to select the TLS
>>     cert.
>>
>> [ketan]
>> Is there another identity that can be used for uniquely identifying instances?
>> The requirement was to enforce vdisk access to owner instances.
>
> The qemu_uuid weak attribute looks suspect.  What is going to provide a
> strong qemu_uuid symbol?
>
> Why aren't configuration parameters like the UUID coming from the QEMU
> command-line?
>
> Stefan

UUID will in fact come from the QEMU command line. VxHS is not doing
anything special here. It will just use the value already available to
qemu-kvm process.

QemuUUID qemu_uuid;
bool qemu_uuid_set;

Both the above are defined in vl.c. vl.c will provide the strong
symbol when available. There are certain binaries that do not get
linked with vl.c (e.g. qemu-img). The weak symbol will come into
affect for such binaries, and in this case, the default VXHS UUID will
get picked up. I had, in a previous email, explained how we plan to
use the default UUID. In the regular case, the VxHS controller will
not allow access to the default UUID (non qemu-kvm) binaries, but it
may choose to grant temporary access to specific vdisks for these
binaries depending on the workflow.

Regards,
Ashish
