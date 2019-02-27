Received: from eggs.gnu.org ([209.51.188.92]:46293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gz0kk-0002eu-AA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gz0ki-0002DG-61
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:04:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gz0kh-0002Ba-RP
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:04:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5D7830024E7
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 14:56:49 +0000 (UTC)
References: <20190118140336.GA19921@beluga.usersys.redhat.com>
	<20190221143915.GB2506@beluga.usersys.redhat.com>
	<734bb989-ba08-edaf-6ea4-3fa84903fc3d@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <9d1edf2b-b9f1-c711-2aac-4a07d69cfaca@redhat.com>
Date: Wed, 27 Feb 2019 11:56:41 -0300
MIME-Version: 1.0
In-Reply-To: <734bb989-ba08-edaf-6ea4-3fa84903fc3d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Libvirt upstream CI efforts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Erik Skultety <eskultet@redhat.com>, libvir-list@redhat.com
Cc: Yash Mankad <ymankad@redhat.com>, qemu-devel@nongnu.org


On 02/21/2019 03:50 PM, Cleber Rosa wrote:
>
> On 2/21/19 9:39 AM, Erik Skultety wrote:
>> Hi,
>> I'm starting this thread in order to continue with the ongoing efforts to
>> bring actual integration testing to libvirt. Currently, the status quo is that
>> we build libvirt (along with our unit test suite) using different OS-flavoured
>> VMs in ci.centos.org. Andrea put a tremendous amount of work to not only
>> automate the whole process of creating the VMs but also having a way for a
>> dev to re-create the same environment locally without jenkins by using the
>> lcitool.
>>
> Nice to meet you lcitool!  I spent some time looking and testing it, and
> I see tremendously value in allowing developers have the same experience
> locally (or anywhere else they choose) as opposed to only behind a
> black(-ish) box environment.  Yash may remember some of our
> conversations about that.  The problem lcitool solves is common (I'm
> having that myself for "deployment checks", AKA integration tests, of
> Avocado itself)[1].
>
> Hopefully not diverting too much from the main topic, but I'd like to
> ask if there was a specific reason for installing guests instead of
> reusing something like virt-builder?  This is my "provision" step that I
> use locally:
>
>    $ virsh destroy $DOMAIN; virt-builder
> --ssh-inject=root:file:$SSH_PUB_KEY --selinux-relabel
> --root-password=password:$PASSWORD --output=$VM_BASE_DIR/$DOMAIN.qcow2
> --format=qcow2 --install python2 $GUEST_TYPE && virsh start $DOMAIN
>
> Which seems to be quicker and simpler than maintaining kickstart files.
>   It also covers more guests (should work for FreeBSD which seem to have
> some caveats on lcitool).  Ideally, I'd like ansible to be responsible
> for it (and it'd be fine that it calls this or something else).  But I
> haven't looked at how well ansible will take this (maybe a dynamic
> inventory implementation is all that's needed).

At Red Hat, the downstream CI system for QEMU uses Linchpin[1] to 
provision bare-metal machines on Beaker [2].

Linchpin is an Ansible based tool that allows to provision (and destroy) 
resources with various providers, for example, Libvirt, Openstack, and 
Duffy [3] (behind of ci.centos.org). On provision success, it generates 
an Ansible inventory file which can be used run tasks on the resources.

It would be good if we could adopt that tool upstream, so have a "common 
language" for provision resources across Libvirt and QEMU CI projects, 
and eventually making Linchpin a better tool.

Okay, there are limitations... it does not provision Docker containers 
yet, for example. I'm working on it [4] though.

Regards,

Wainer

[1] https://linchpin.readthedocs.io/en/latest/index.html
[2] https://beaker-project.org/
[3] https://wiki.centos.org/QaWiki/CI/Duffy
[4] https://github.com/CentOS-PaaS-SIG/linchpin/pull/977


>
>> #TL;DR (if you're from QEMU, no TLDR for you ;), there are questions to answer)
>> - we need to run functional tests upstream on ci.centos.org
>>      -> pure VM testing environment (nested for migration) vs Docker images
>> - we need to host the upstream test suite somewhere
>>      -> main libvirt.git repo vs libvirt-jenkins-ci.git vs new standalone repo
>> - what framework to use for the test suite
>>      -> TCK vs avocado-vt vs plain avocado
>>
>> #THE LONG STORY SHORT
>> As far as the functional test suite goes, there's an already existing
>> integration with the avocado-vt and a massive number of test cases at [1]
>> which is currently not used for upstream testing, primarily because of the huge
>> number of test cases (and also many unnecessary legacy test cases). An
>> alternative set of functional test cases is available as part of the
>> libvirt-tck framework [2]. The obvious question now is how can we build upon
>> any of this and introduce proper functional testing of upstream libvirt to our
>> jenkins environment at ci.centos.org, so I formulated the following discussion
>> points as I think these are crucial to sort out before we move on to the test
>> suite itself:
>>
>> * Infrastructure/Storage requirements (need for hosting pre-build images?)
>>       - one of the main goals we should strive for with upstream CI is that
>>         every developer should be able to run the integration test suite on
>>         their own machine (conveniently) prior to submitting their patchset to
>>         the list
>>       - we need a reproducible environment to ensure that we don't get different
>>         results across different platforms (including ci.centos.org), therefore
>>         we could provide pre-built images with environment already set up to run
>>         the suite in an L1 guest.
> This seems to match the virt-builder approach.
>
>>       - as for performing migration tests, we could utilize nested virt
>>       - should we go this way, having some publicly accessible storage to host
>>         all the pre-built images is a key problem to solve
>>
>>             -> an estimate of how much we're currently using: roughly 130G from
>>                our 500G allocation at ci.centos.org to store 8 qcow2 images + 2
>>                freebsd isos
>>
> Maybe this just needs to become a repository that developers can also
> download from?  This would require the FreeBSD ISOs (and installation)
> to be converted into a similar pre-built image use, though.
>
>>             -> we're also fairly generous with how much we allocate for a guest
>>                image as most of the guests don't even use half of the 20G
>>                allocation
>>
>>             -> considering sparsifying the pre-built images and compressing them
>>                + adding a ton of dependencies to run the suite, extending the
>>                pool of distros by including ubuntu 16 + 18, 200-250G is IMHO
>>                quite a generous estimate of our real need
>>
>>             -> we need to find a party willing to give us the estimated amount
>>                of publicly accessible storage and consider whether we'd need any
>>                funds for that
>>
>>             -> we'd have to also talk to other projects that have done a similar
>>                thing about possible caveats related to hosting images, e.g.
>>                bandwidth
> We're hosting a very small number of images (and small images in size) here:
>
>    https://avocado-project.org/data/assets/
>
> There's at least one image that gets downloaded on every single
> Avocado-VT installation (vt-bootstrap) by default.  I have to admit I
> haven't monitored the bandwidth usage, but it hasn't gone over the quota
> (and we're paying ~5 USD/month for that server).
>
>>             -> as for ci.centos.org, it does provide publicly accessible folder
>>                where projects can store artifacts (the documentation even
>>                mentions VM images), there might a limit though [3]
>>
>>       - alternatively, we could use Docker images to test migration instead of
>>         nested virt (and not only migration)
>>             -> we'd loose support for non-Linux platforms like FreeBSD which we
>>                would not if we used nested
>>
> One must pay attention to capabilities, seccomp and other layers added
> to containers.  I'm not fully confident that the results of
> virtualization testing under a container (specially failures) are just
> as good as results from a non-containerized environment.  But I may be
> on track to changing my opinion on this matter.
>
>> * Hosting the test suite itself
>>       - the main point to discuss here is whether the test suite should be part
>>         of the main libvirt repo following QEMU's lead by example or should they
>>         live inside a separate repo (a new one or as part of
>>         libvirt-jenkins-ci [4]
>>             -> the question here for QEMU folks is:
>>
>>         *"What was the rationale for QEMU to decide to have avocado-qemu as
>>          part of the main repo?"*
>>
> Whenever you have an external test suite, you loose the automatic
> version matching of the component you're testing.  Then conditionals,
> abstractions, special treatments for the components we're testing tend
> to plague everything.  Avocado-VT/tp-{qemu,libvirt} are examples of test
> frameworks repositories that may still support 10 years or so of
> different software versions.  The end result is *not* nice because:
>
>    * Abstraction increases to support multiple versions of everything
>    * Learning curve goes through the roof
>    * Developers don't take the time to learn a complex framework full of
> abstractions
>    * QE does take the time, because they usually need to more than one
> version of a software
>    * Developers and QE now have their own silos
>
> You could overcome some of that by keeping policies on supported
> versions, baby sitting and deprecating code, but I firmly believe that
> those house keeping tasks are bound to fail.
>
> There's one thing developers will take immediate action on, and that is
> when a "make check[-functional]" fails... so a test suite in this sense
> need to be intrusive and affect a developer's common workflow.
>
>> * What framework to use for the test suite
>>       - libvirt-tck because it already contains a bunch of very useful tests as
>>         mentioned in the beginning
>>       - using the avocado-vt plugin because that's what's the existing
>>         libvirt-test-provider [1] is about
>>       - pure avocado for its community popularity and continuous development and
>>         once again follow QEMU leading by example
>>             -> and again a question for QEMU folks:
>>
>>         *"What was QEMU's take on this and why did they decide to go with
>>          avocado-qemu?"*
>>
> Well, "avocado-qemu" did not exist when we initially pursued this task.
>   Besides the points above, as to why keeping the tests as part of the
> main repo, we understand that there are a lot of common problems in
> testing.  They're usually solved over and over again, in an ad-hoc
> manner for each project.
>
> (Pure) Avocado was for a long time nothing but a speculation of what we
> believed most projects would need for their testing (and an Avocado-VT
> compatibility layer).  We got somethings right, and somethings wrong.
>
> During the last year or so, a number of Avocado features have been added
> for the sake of QEMU testing (for the "avocado-qemu" initiative), but I
> bet that a user reading the documentation won't guess that.  Those
> features are abstract and should work for any other project.
>
> So, along the way, we had confidence that the testing stack could be
> shared and split, and that tests living within the main repo ended up
> looking simple and effective.  The "glue" between tests and framework is
> quite thin and the bootstrap can be done transparently as part of the
> "make check-acceptance" target.  We haven't heard from developers any
> resistance to this approach, so, so far, we believe we're on the right
> track.
>
>> * Integrating the test suite with the main libvirt.git repo
>>       - if we host the suite as part of libvirt-jenkins-ci as mentioned in the
>>         previous section then we could make libvirt-jenkins-ci a submodule of
>>         libvirt.git and enhance the toolchain by having something like 'make
>>         integration' that would prepare the selected guests and execute the test
>>         suite in them (only on demand)
>>
> Yes, this is the type of experience that should ultimately be delivered.
>
>> Regards,
>> Erik
>>
>> [1] https://github.com/autotest/tp-libvirt
>> [2] https://libvirt.org/testtck.html
>> [3] https://wiki.centos.org/QaWiki/CI/GettingStarted#head-a46ee49e8818ef9b50225c4e9d429f7a079758d2
>> [4] https://github.com/libvirt/libvirt-jenkins-ci
>>
> [1]
> https://github.com/avocado-framework/avocado/tree/master/selftests/deployment
>
