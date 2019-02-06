Received: from eggs.gnu.org ([209.51.188.92]:53980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suman.swaroop@rubrik.com>) id 1grQse-0005e7-62
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suman.swaroop@rubrik.com>) id 1grQsc-0007mN-3X
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:21:00 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:40623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <suman.swaroop@rubrik.com>)
	id 1grQsb-0007kb-Ik
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:20:58 -0500
Received: by mail-qt1-x82f.google.com with SMTP id j36so6416398qta.7
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 09:20:56 -0800 (PST)
MIME-Version: 1.0
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
	<e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
	<CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
	<9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
	<20190124091649.GF23279@paraplu>
	<CAMAMwPA_H77fnC+dOzBt+nRQ+=oPHtpw2DRYMCEtnGdo1OU0Hw@mail.gmail.com>
In-Reply-To: <CAMAMwPA_H77fnC+dOzBt+nRQ+=oPHtpw2DRYMCEtnGdo1OU0Hw@mail.gmail.com>
From: Suman Swaroop <suman.swaroop@rubrik.com>
Date: Wed, 6 Feb 2019 22:50:44 +0530
Message-ID: <CAJjBnT+dL8aamDoqMHDaq1GUTrvd+Yp3h0=zqcMy9HRLzXVtXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>, qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>, Kashyap Chamarthy <kashyap.cv@gmail.com>, John Snow <jsnow@redhat.com>

  Hey, some continuation questions from above discussion,


   1.

   Comments in blockdev-add command section in patch
   https://patchwork.kernel.org/patch/9638133/ says that
   =E2=80=9CNote: This command is still a work in progress. It doesn't supp=
ort all
   block drivers among other things. Stay away from it unless you want to h=
elp
   with its development.=E2=80=9D Does it work with qcow2 and raw from vers=
ion 2.3?
   2.

   When new nodes are added in chain, there is an associated backing image
   file as well. Some of these image files become redundant when a node is
   merged with other nodes. While issuing qmp commands to qemu via libvirt =
tls
   socket, there does not seem to be any functionality available to delete =
the
   redundant image files. Basically when a node is streamed or committed, t=
he
   node and its backing image file can be deleted as they are not required
   anymore. Is there any qmp command to achieve the same with the constrain=
t
   that we only have access to libvirt tls socket and cannot ssh to the hos=
t?
   3.

   In filename path of blockdev-add command or target path of drive-backup
   command can we provide nfs urld directly for the image path i.e
   nfs://<ip>/foo(not a mounted directory)? This is related to the point 2
   above that we do not have root ssh access to the host but only access to
   its tls socket


Suman

On Thu, Jan 24, 2019 at 6:12 PM Bharadwaj Rayala <
bharadwaj.rayala@rubrik.com> wrote:

> Hi Eric, Kashyap,
>
> I work for Rubrik. I am trying to implement first class support for
> protection of rhev instances using rubrik. I want the solution to be
> generic and be a step towards protection of any kvm instance with any
> management layer(standalone kvm/rhel host, rhev/ovirt clusters, openstack
> clusters ...). But first l am just concentrating on the rhev flow. This
> backup program would be a proprietary product.
>
> I looked at the rhev recommended way for backups.
> https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.2/=
html/administration_guide/sect-backing_up_and_restoring_virtual_machines_us=
ing_the_backup_and_restore_api
> This doesnot make use of qemu block jobs for incremental ingest, or dirty
> bitmaps. Entire responsibility is on the backup program to take backups,
> and the best one can do is to do a block by block fingerprint on the whol=
e
> drive and then do an incremental ingest by comparing fp with fp's of the
> base snapshot.
>
> I wanted to build something that directly talks to rhev(or any kvm) hosts
> using libvirt and use block jobs and dirty bitmaps to do cbt like, but pu=
sh
> based ingest. We need to support 4.1 version of rhev, which contains
> qmeu-kvm-rhev 2.6.0-28.el7_3.9 which has (almost) all the functionality
> that we need. I know that write access through libvirt is not supported b=
y
> rhev right now [1]
> <https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.2=
/html/product_guide/accessing-rhv>.
> I am trying to find a non invasive way of accessing qemu drive-backup blo=
ck
> job through libvirt(using qemu-monitor-command, libvirt2.0 in rhev4.1
> doesnot have drive-backup) that does not interfere with user driven
> snapshots/interactions from rhev ui/api. I am not sure if I can continue =
on
> this path though, with the information Eric has provided on user driven
> snapshots. Please do let me know if you have any comments/better ideas.
>
> Currently i am talking to libvirt hosts over tls socket (virsh -c
> qemu+tls://rhevnode1/system ), by certifying rubrik nodes from which back=
up
> is triggered using the same CA.key manager uses to certify its own nodes.=
 I
> already read your wikis on incremental live backups and dirty bitmaps. Th=
ey
> are a great find. TY
>
> Bharadwaj.
>
> On Thu, Jan 24, 2019 at 2:46 PM Kashyap Chamarthy <kchamart@redhat.com>
> wrote:
>
>> On Wed, Jan 23, 2019 at 01:09:41PM -0600, Eric Blake wrote:
>> > On 1/23/19 12:08 PM, Bharadwaj Rayala wrote:
>>
>> [...] # [Snip Eric's excellent exposition.]
>>
>> > > What do you mean by issues? Do you mean any data/corruption bugs or
>> lack of
>> > > some nice functionality that we are talking here?
>> >
>> > Lack of functionality.  In particular, the 4.0 commands
>> > block-dirty-bitmap-{enable,merge,disable} (or their 3.1 counterparts
>> > x-block-dirty-bitmap-*) are essential to the workflow of differential
>> > backups (without being able to manage bitmaps yourself, you can only g=
et
>> > the weaker incremental backup, and that means qemu itself is clearing
>> > the bitmap out of under your feet on success, and where you are having
>> > to worry about completion-mode=3Dgrouped).
>> >
>> > >
>> > > Thanks a lot Eric for spending your time in answering my queries. I
>> dont
>> > > know if you work with Kashyap Chamarthy, but your help and his blogs
>> are
>> > > lifesavers.
>> >
>> > Yes, Kashyap is trying to build solutions on top of the building block=
s
>> > that I am working on, so we have collaborated several times on these
>> > types of issues (he does a lot better at blog posts extracted from my
>> > mailing list brain dumps).
>>
>> I haven't kept up with incremental backups lately, as I've been swamped
>> with other work.  But two other documents that I can point to are these
>> [1][2] in the QEMU tree.  And their HTML-rendered versions are
>> here[3][4].  They're generated for 3.0.0; but these docs haven't changed
>> much since then.
>>
>> Along with Eric's last year talk, also check out presentations from
>> previous KVM Forums from other Block Layer maintainers.
>>
>>
>> [1]
>> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/live-block-=
operations.rst
>> [2] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/bitmaps=
.rst
>> [3]
>> https://kashyapc.fedorapeople.org/QEMU-Docs-v3.0.0/_build/html/docs/inte=
rop/live-block-operations.html
>> [4]
>> https://kashyapc.fedorapeople.org/QEMU-Docs-v3.0.0/_build/html/docs/inte=
rop/bitmaps.html
>>
>>
>> --
>> /kashyap
>>
>
>
> --
> [image: photo]
> Bharadwaj Rayala
> Software Engineer at Rubrik
> M  +919618462233  <+919618462233> E  bharadwaj.rayala@rubrik.com
> <bharadwaj.rayala@rubrik.com> W  www.rubrik.com
> <http://www.rubrik.com?utm_source=3DWiseStamp&utm_medium=3Demail&utm_term=
=3D&utm_content=3D&utm_campaign=3Dsignature>
>
>
