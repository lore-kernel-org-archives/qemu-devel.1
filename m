Received: from eggs.gnu.org ([209.51.188.92]:50667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gwpbZ-0005P1-6q
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gwpbX-0005yN-TO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gwpbX-0005wE-IH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:45:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49F9A3003193
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 14:39:21 +0000 (UTC)
Date: Thu, 21 Feb 2019 15:39:15 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20190221143915.GB2506@beluga.usersys.redhat.com>
References: <20190118140336.GA19921@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118140336.GA19921@beluga.usersys.redhat.com>
Subject: [Qemu-devel] Libvirt upstream CI efforts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com
Cc: Yash Mankad <ymankad@redhat.com>, Cleber Rosa Junior <crosa@redhat.com>, qemu-devel@nongnu.org

Hi,
I'm starting this thread in order to continue with the ongoing efforts to
bring actual integration testing to libvirt. Currently, the status quo is that
we build libvirt (along with our unit test suite) using different OS-flavoured
VMs in ci.centos.org. Andrea put a tremendous amount of work to not only
automate the whole process of creating the VMs but also having a way for a
dev to re-create the same environment locally without jenkins by using the
lcitool.

#TL;DR (if you're from QEMU, no TLDR for you ;), there are questions to answer)
- we need to run functional tests upstream on ci.centos.org
    -> pure VM testing environment (nested for migration) vs Docker images
- we need to host the upstream test suite somewhere
    -> main libvirt.git repo vs libvirt-jenkins-ci.git vs new standalone repo
- what framework to use for the test suite
    -> TCK vs avocado-vt vs plain avocado

#THE LONG STORY SHORT
As far as the functional test suite goes, there's an already existing
integration with the avocado-vt and a massive number of test cases at [1]
which is currently not used for upstream testing, primarily because of the huge
number of test cases (and also many unnecessary legacy test cases). An
alternative set of functional test cases is available as part of the
libvirt-tck framework [2]. The obvious question now is how can we build upon
any of this and introduce proper functional testing of upstream libvirt to our
jenkins environment at ci.centos.org, so I formulated the following discussion
points as I think these are crucial to sort out before we move on to the test
suite itself:

* Infrastructure/Storage requirements (need for hosting pre-build images?)
     - one of the main goals we should strive for with upstream CI is that
       every developer should be able to run the integration test suite on
       their own machine (conveniently) prior to submitting their patchset to
       the list
     - we need a reproducible environment to ensure that we don't get different
       results across different platforms (including ci.centos.org), therefore
       we could provide pre-built images with environment already set up to run
       the suite in an L1 guest.
     - as for performing migration tests, we could utilize nested virt
     - should we go this way, having some publicly accessible storage to host
       all the pre-built images is a key problem to solve

           -> an estimate of how much we're currently using: roughly 130G from
              our 500G allocation at ci.centos.org to store 8 qcow2 images + 2
              freebsd isos

           -> we're also fairly generous with how much we allocate for a guest
              image as most of the guests don't even use half of the 20G
              allocation

           -> considering sparsifying the pre-built images and compressing them
              + adding a ton of dependencies to run the suite, extending the
              pool of distros by including ubuntu 16 + 18, 200-250G is IMHO
              quite a generous estimate of our real need

           -> we need to find a party willing to give us the estimated amount
              of publicly accessible storage and consider whether we'd need any
              funds for that

           -> we'd have to also talk to other projects that have done a similar
              thing about possible caveats related to hosting images, e.g.
              bandwidth

           -> as for ci.centos.org, it does provide publicly accessible folder
              where projects can store artifacts (the documentation even
              mentions VM images), there might a limit though [3]

     - alternatively, we could use Docker images to test migration instead of
       nested virt (and not only migration)
           -> we'd loose support for non-Linux platforms like FreeBSD which we
              would not if we used nested

* Hosting the test suite itself
     - the main point to discuss here is whether the test suite should be part
       of the main libvirt repo following QEMU's lead by example or should they
       live inside a separate repo (a new one or as part of
       libvirt-jenkins-ci [4]
           -> the question here for QEMU folks is:

       *"What was the rationale for QEMU to decide to have avocado-qemu as
        part of the main repo?"*

* What framework to use for the test suite
     - libvirt-tck because it already contains a bunch of very useful tests as
       mentioned in the beginning
     - using the avocado-vt plugin because that's what's the existing
       libvirt-test-provider [1] is about
     - pure avocado for its community popularity and continuous development and
       once again follow QEMU leading by example
           -> and again a question for QEMU folks:

       *"What was QEMU's take on this and why did they decide to go with
        avocado-qemu?"*


* Integrating the test suite with the main libvirt.git repo
     - if we host the suite as part of libvirt-jenkins-ci as mentioned in the
       previous section then we could make libvirt-jenkins-ci a submodule of
       libvirt.git and enhance the toolchain by having something like 'make
       integration' that would prepare the selected guests and execute the test
       suite in them (only on demand)

Regards,
Erik

[1] https://github.com/autotest/tp-libvirt
[2] https://libvirt.org/testtck.html
[3] https://wiki.centos.org/QaWiki/CI/GettingStarted#head-a46ee49e8818ef9b50225c4e9d429f7a079758d2
[4] https://github.com/libvirt/libvirt-jenkins-ci
