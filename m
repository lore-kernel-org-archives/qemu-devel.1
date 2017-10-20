Received: from eggs.gnu.org ([2001:4830:134:3::10]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhartmay@linux.vnet.ibm.com>) id 1e5VBM-0004xC-3b
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhartmay@linux.vnet.ibm.com>) id 1e5VBI-0002kJ-SZ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:09:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhartmay@linux.vnet.ibm.com>)
	id 1e5VBI-0002ju-MO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:09:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KAx2OX044487
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 07:09:32 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dqbwdw923-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 07:09:32 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mhartmay@linux.vnet.ibm.com>;
	Fri, 20 Oct 2017 12:09:30 +0100
From: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
In-Reply-To: <20171012120714.GA314661@orkuz.home>
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
Date: Fri, 20 Oct 2017 13:09:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Thu, Oct 12, 2017 at 02:07 PM +0200, Jiri Denemark <jdenemar@redhat.com>=
 wrote:
> On Mon, Oct 09, 2017 at 10:16:48 +0200, Marc Hartmayer wrote:
>> On Thu, Oct 05, 2017 at 02:11 PM +0200, Jiri Denemark <jdenemar@redhat.c=
om> wrote:
>> > But it's going to be a bit complicated because we ask QEMU what the
>> > host CPU is and the interface we used would need to be enhanced to
>> > give us different results for all supported machine types so that we
>> > can select the right one when a domain is started.
>>
>> So how do we deal with this?
>
> I think we need to start discussing this on qemu-devel list. If I
> remember correctly, David Hildenbrand is the original author of the
> query-cpu-model-expansion QMP command.
>
> Please, Cc me so that the thread is more visible to me.
>
> Thanks,
>
> Jirka
>

Hi all,

we recently encountered the problem that the 'host-model' [1] has to be
related to the machine type of a domain. We have following problem:

   Let's assume we've a z13 system with a QEMU 2.9 and we define a
   domain using the default s390-virtio-ccw machine together with the
   host-model CPU mode [1]. The definition will have the machine
   expanded to s390-virtio-ccw-2.9 but retain the host-model CPU mode
   in the domain definition. In a next step we upgrade to QEMU 2.10
   (first version to recognize z14). Everything is still fine, even
   though the machine runs in 2.9 compatibility mode. Finally we
   upgrade to a z14. As a consequence it is not possible to start the
   domain anymore as the machine type doesn't support our CPU host
   model (which is expanded at start time of the domain).

For determining the actual host-model the QMP command
'query-cpu-model-expansion' is used. This is done once per QEMU binary
and the result of it is cached by libvirt. The problem with that is
that libvirt queries with the newest machine type of the QEMU binary
for the host CPU model. But now we realized that we have to consider
the machine type of each domain for the determination of the host CPU
model of a domain.

We could now either probe the host CPU model for each QEMU binary +
machine type combination and for this we've to start a new QEMU
process each time. Or we can add a QMP command/parameter that allows
us to determine the host CPU model(s) with respect to the passed
machine type and/or all supported machine types.

The QMP command query-cpu-model-expansion is currently described in
qapi-schema.json as follows:

<quotation>
##
# @query-cpu-model-expansion:
#
# Expands a given CPU model (or a combination of CPU model + additional opt=
ions)
# to different granularities, allowing tooling to get an understanding what=
 a
# specific CPU model looks like in QEMU under a certain configuration.
#
# This interface can be used to query the "host" CPU model.
#
# The data returned by this command may be affected by:
#
# * QEMU version: CPU models may look different depending on the QEMU versi=
on.
# (Except for CPU models reported as "static" in query-cpu-definitions.)
# * machine-type: CPU model may look different depending on the machine-typ=
e.
# (Except for CPU models reported as "static" in query-cpu-definitions.)
# * machine options (including accelerator): in some architectures, CPU mod=
els
# may look different depending on machine and accelerator options. (Except =
for
# CPU models reported as "static" in query-cpu-definitions.)
# * "-cpu" arguments and global properties: arguments to the -cpu option and
# global properties may affect expansion of CPU models. Using
# query-cpu-model-expansion while using these is not advised.
#
# Some architectures may not support all expansion types. s390x supports
# "full" and "static".
#
# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU model=
s is
# not supported, if the model cannot be expanded, if the model contains
# an unknown CPU definition name, unknown properties or properties
# with a wrong type. Also returns an error if an expansion type is
# not supported.
#
# Since: 2.8.0
##
{ 'command': 'query-cpu-model-expansion',
'data': { 'type': 'CpuModelExpansionType',
'model': 'CpuModelInfo' },
'returns': 'CpuModelExpansionInfo' }

4:46:25 PM
=E2=97=84
qapi-schema.json
</quotation>

What do you think?

Thank you.

 Marc



[1] https://libvirt.org/formatdomain.html#elementsCPU

--
Beste Gr=C3=BC=C3=9Fe / Kind regards
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
