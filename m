Received: from eggs.gnu.org ([209.51.188.92]:54338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwtgT-0000OC-7P
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwtgR-0004fP-0X
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:07:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gwtgP-0004a4-2P
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:06:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D46CA81DF5
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 19:06:49 +0000 (UTC)
References: <20190118140336.GA19921@beluga.usersys.redhat.com>
	<20190221143915.GB2506@beluga.usersys.redhat.com>
	<20190221175638.GP17899@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <e9e77e96-377b-a446-40cb-eec271e382b1@redhat.com>
Date: Thu, 21 Feb 2019 14:06:44 -0500
MIME-Version: 1.0
In-Reply-To: <20190221175638.GP17899@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] Libvirt upstream CI efforts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Erik Skultety <eskultet@redhat.com>
Cc: libvir-list@redhat.com, Yash Mankad <ymankad@redhat.com>, qemu-devel@nongnu.org



On 2/21/19 12:56 PM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Feb 21, 2019 at 03:39:15PM +0100, Erik Skultety wrote:
>> Hi,
>> I'm starting this thread in order to continue with the ongoing efforts=
 to
>> bring actual integration testing to libvirt. Currently, the status quo=
 is that
>> we build libvirt (along with our unit test suite) using different OS-f=
lavoured
>> VMs in ci.centos.org. Andrea put a tremendous amount of work to not on=
ly
>> automate the whole process of creating the VMs but also having a way f=
or a
>> dev to re-create the same environment locally without jenkins by using=
 the
>> lcitool.
>=20
> Note that it is more than just libvirt on the ci.centos.org host. Our
> current built project list covers libosinfo, libvirt, libvirt-cim,
> libvirt-dbus, libvirt-glib, libvirt-go, libvirt-go-xml, libvirt-ocaml,
> libvirt-perl, libvirt-python, libvirt-sandbox, libvirt-tck, osinfo-db,
> osinfo-db-tools, virt-manager & virt-viewer
>=20
> For the C libraries in that list, we've also built & tested for
> mingw32/64. All the projects also build RPMs.
>=20
> In addition to ci.centos.org we have Travis CI testing for several
> of the projects - libvirt, libvirt-go, libvirt-go-xml, libvirt-dbus,
> libvirt-rust and libvirt-python. In the libvirt case this uses Docker
> containers, but others just use native Travis environment. Travis is
> the only place we get macOS coverage for libvirt.
>=20
> Finally everything is x86-only right now, though I've been working on
> using Debian to build cross-compiler container environments to address
> that limitation.
>=20
> We also have patchew scanning libvir-list and running syntax-check
> across patches though it has not been very reliably running in
> recent times which is a shame.
>=20
>=20
>> #THE LONG STORY SHORT
>> As far as the functional test suite goes, there's an already existing
>> integration with the avocado-vt and a massive number of test cases at =
[1]
>> which is currently not used for upstream testing, primarily because of=
 the huge
>> number of test cases (and also many unnecessary legacy test cases).
>> An alternative set of functional test cases is available as part of th=
e
>> libvirt-tck framework [2]. The obvious question now is how can we buil=
d upon
>> any of this and introduce proper functional testing of upstream libvir=
t to our
>> jenkins environment at ci.centos.org, so I formulated the following di=
scussion
>> points as I think these are crucial to sort out before we move on to t=
he test
>> suite itself:
>>
>> * Infrastructure/Storage requirements (need for hosting pre-build imag=
es?)
>>      - one of the main goals we should strive for with upstream CI is =
that
>>        every developer should be able to run the integration test suit=
e on
>>        their own machine (conveniently) prior to submitting their patc=
hset to
>>        the list
>=20
> Any test suite that developers are expected to run before submissions
> needs to be reasonably fast to run, and above all it needs to be very r
> eliable. If it is slow, or wastes time by giving false positives, devel=
opers
> will quickly learn to not bother running it.
>=20
> This neccessarily implies that what developers run will only be a small
> subset of what the CI systems run.
>=20
> Developers just need to be able to then reproduce failures from CI
> in some manner locally to debug things after the fact.=20
>=20
>>      - we need a reproducible environment to ensure that we don't get =
different
>>        results across different platforms (including ci.centos.org), t=
herefore
>>        we could provide pre-built images with environment already set =
up to run
>>        the suite in an L1 guest.
>>      - as for performing migration tests, we could utilize nested virt
>=20
> Migration testing doesn't fundamentally need nested virt. It just needs=
 two
> separate isolated libvirt instances. From POV of libvirt, we're just te=
sting
> our integration with QEMU, for which it is sufficient to use TCG, not K=
VM.
> This could be done with any two VMs, or two container environments.
>=20
>>      - should we go this way, having some publicly accessible storage =
to host
>>        all the pre-built images is a key problem to solve
>>
>>            -> an estimate of how much we're currently using: roughly 1=
30G from
>>               our 500G allocation at ci.centos.org to store 8 qcow2 im=
ages + 2
>>               freebsd isos
>>
>>            -> we're also fairly generous with how much we allocate for=
 a guest
>>               image as most of the guests don't even use half of the 2=
0G
>>               allocation
>>
>>            -> considering sparsifying the pre-built images and compres=
sing them
>>               + adding a ton of dependencies to run the suite, extendi=
ng the
>>               pool of distros by including ubuntu 16 + 18, 200-250G is=
 IMHO
>>               quite a generous estimate of our real need
>>
>>            -> we need to find a party willing to give us the estimated=
 amount
>>               of publicly accessible storage and consider whether we'd=
 need any
>>               funds for that
>>
>>            -> we'd have to also talk to other projects that have done =
a similar
>>               thing about possible caveats related to hosting images, =
e.g.
>>               bandwidth
>>
>>            -> as for ci.centos.org, it does provide publicly accessibl=
e folder
>>               where projects can store artifacts (the documentation ev=
en
>>               mentions VM images), there might a limit though [3]
>>
>>      - alternatively, we could use Docker images to test migration ins=
tead of
>>        nested virt (and not only migration)
>>            -> we'd loose support for non-Linux platforms like FreeBSD =
which we
>>               would not if we used nested
>=20
> This is a false dichotomy, as use of Docker and VM images are not mutal=
ly
> exclusive.
>=20
> The problems around need for large disk storage and bandwidth requireme=
nts
> for hosting disk images are a nice illustration of why the use of conta=
iners
> for build & test environments has grown so quickly to become a defacto =
standard
> approach.
>=20
> The image storage & bandwidth issue becomes someone else problem, where=
 that
> someone else is Docker Hub or Quay.io, and thus incurrs financial or ad=
min
> costs to the project. When using public services though, we should of c=
ourse
> be careful not to get locked into a specific vendor's service. Fortunat=
ely
> docker images are widely supported enough that this isn't a big issue, =
as
> we've already proved by switching from Dockre Hub to Quay.io for our cu=
rrent
> images.
>=20
> The added benefit of containers is that developers don't then require a=
 system
> with physical or nested virt in order to run the environment. The conta=
iners
> can run efficiently on any hardware available, phyiscal or virtual.
>=20
> The vast majority of our targetted build platforms are Linux based, so =
can
> be hosted via containers. The *BSD platforms can remain using disk imag=
es.
>=20
> Provided that developers have a automated mechanism for creating the *B=
SD
> images (using lcitool as today), then I don't see a compelling need to
> actually provide hosting for pre-built VM disk images. Developers can b=
uild
> them locally as & when they are needed.
>=20
>=20
>=20
> In terms of infrastructure I think the most critical thing we are lacki=
ng
> is the hardware resource for actually running the CI systems, which is =
a
> definite blocker if we want to run any kind of extensive functional /
> integration tests.
>=20
> We could make better use of our current ci.centos.org server by switchi=
ng
> the Linux environments to use Docker. This would reduce the memory foot=
print
> of each environment significantly, as we'd not be statically partitioni=
ng
> up RAM to each env. It would improve our CPU utilization by allowing ea=
ch job
> to access all host CPUs, with the host OS balancing. Currently each VM =
only
> gets 2 vCPUs, out of 8 in the host. So in times where only 1 job is run=
ning
> we've wasted 3/4 of our CPU resource.  We could increase all the VMs to=
 have
> 8 vCPUs, which could improve things but it still has 2 schedulars invol=
ved,
> so won't be as resource efficient as containers.
>=20
> Regardless of any improvements to current utilization though, I don't s=
ee
> the current hardware having sufficient capacity to run serious integrat=
ion
> tests, especially if we want the integration tests run on multiple OS
> targets.
>=20
> IOW the key blocker is a 2nd server that we can register to ci.centos.o=
rg for
> running jenkins jobs.  Our original server was a gift from the CentOS p=
roject
> IIUC. If CentOS don't have the capacity to provide a second server, the=
n I
> think we should push Red Hat to fund it, given how fundamental the libv=
irt
> project is to Red Hat.
>=20
>> * Hosting the test suite itself
>>      - the main point to discuss here is whether the test suite should=
 be part
>>        of the main libvirt repo following QEMU's lead by example or sh=
ould they
>>        live inside a separate repo (a new one or as part of
>>        libvirt-jenkins-ci [4]
>=20
> The libvirt-jenkins-ci repository is for tools/scripts/config to manage=
 the
> CI infrastructure itself. No actual tests belong there.
>=20
> I don't think they need to be in the libvirt.git repository either. Lib=
virt
> has long taken the approach of keeping independent parts of the project=
 in
> their own distinct repository, allowing them to live & evolve as best s=
uits
> their needs.  We indeed already have external repos containing integrat=
ion
> tests such as the TCK and the (largely unused now) libvirt-Test-API
>=20
> Having it in a separate repo doesn't prevent us from making it easy to =
run
> the test suite from the master libvirt.git. It is trivial to have make
> rules that will pull in the external repo content. We've already done t=
hat
> with libvirt-go-xml, where we pull in libvirt.git to provide XML files =
for
> testing against.
>=20
>>            -> the question here for QEMU folks is:
>>
>>        *"What was the rationale for QEMU to decide to have avocado-qem=
u as
>>         part of the main repo?"*
> =20
>> * What framework to use for the test suite
>>      - libvirt-tck because it already contains a bunch of very useful =
tests as
>>        mentioned in the beginning
>>      - using the avocado-vt plugin because that's what's the existing
>>        libvirt-test-provider [1] is about
>>      - pure avocado for its community popularity and continuous develo=
pment and
>>        once again follow QEMU leading by example
>>            -> and again a question for QEMU folks:
>=20
> I think there's two distinct questions / decision points there. There
> the harness that controls execution & reporting results of the tests,
> and there is the framework for actually writing individual tests.
>=20
> The libvirt-TCK originally has Perl's Test::Harness for running and
> reporting the tests. The actual test cases are using the TAP protocol
> for their output. The test cases written in Perl use Test::More for
> generating TAP output, the tests cases written in shell just write
> TAP format results directly.
>=20
> The test cases can thus be executed by anything that knows how to
> consume the TAP format. Likewises tests can be writen in Python,
> Go, $whatever, as long as it can emit TAP format.
>=20
> I think such independance is useful as it makes it easy to integrate
> tests with distinct harnesses.
>=20

I agree that putting all your eggs on a single basket is can be bad
thing, but IMO, requiring developers to write code that emits TAP (as
simple as it is) is a clear sign that things are out of place.

I believe most developers would not be able to write TAP compatible
output by heart.  This is just to say that "there should be one obvious
and easy way to do it".  I like the way qemu-iotests behave, because
they don't require this type of burden on the test writer, still, they
can be written in a number of ways (shell, Python unittest, plain
Python, etc).

> I also think there's really not any single "best" test suite. We
> already have multiple, and they have different levels of coverage
> not least of the API bindings.
>=20
> For example, by virtue of using Perl, the TCK provides integration
> testing of the Sys::Virt API bindings to libvirt.
>=20
> The avocado-vt gives the same benefit to the Python bindings.
>=20

Not that this is super important, but Avocado-VT doesn't use the libvirt
binding, and neither does tp-libvirt (long long story).

> We should just make it easy to run all of the suites that we might
> find useful rather than trying pick a perfect one.
>=20

There can be many indeed. From a product perspective, it'd be nice to
make the contributor life easier by giving a few indications on how to
write a test for what he/she is contributing.  And ideally it should be
as simple as possible.

But this is all pretty obvious :)

- Cleber.

> I should note that the TCK project is not merely intended for upstream
> dev. It was also intended as something for downstream users/admins/
> vendors to use as a way to validate that their specific installation
> of libvirt was operating correctly. As such it goes to some trouble
> to avoid damaging the host system, so that developers can safely
> run it on precious machine. They don't need to setup a throwaway
> box to run it in & it can be launched with zero config & do something
> sensible.
>=20
>>        *"What was QEMU's take on this and why did they decide to go wi=
th
>>         avocado-qemu?"*
>=20
> Note is a bit more complicated than this for QEMU as there's acutally
> many test systems in QEMU
>=20
>  - Unit tests emitting TAP format with GLib's TAP harnes
>  - QTests functional tests emitting TAP format with GLib's TAP harness
>  - Block I/O functional/integration tests emitting a custom format
>    with its own harness
>  - Acceptance (integration) tests using avacado
>=20
>=20
>> * Integrating the test suite with the main libvirt.git repo
>>      - if we host the suite as part of libvirt-jenkins-ci as mentioned=
 in the
>>        previous section then we could make libvirt-jenkins-ci a submod=
ule of
>>        libvirt.git and enhance the toolchain by having something like =
'make
>>        integration' that would prepare the selected guests and execute=
 the test
>>        suite in them (only on demand)
>=20
> Git submodules have the (both useful & annoying) feature that they
> are tied to a specific commit of the submodule. Tieing to a specific
> commit certainly makes sense for build deps like gnulib, but I don't
> think its so clearcut for the test suite. I think it would be useful
> not to have to update the submodule commit hash in libvirt.git any
> time a new useful test was added to the test repo.
>=20
> IOW, it is probably sufficient to simply have "make" do a normal
> git clone of the external repo so it always gets fresh test content.
>=20
> Regards,
> Daniel
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
