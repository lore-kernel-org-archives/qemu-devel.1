Received: from eggs.gnu.org ([209.51.188.92]:42000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw0E5-0007ZC-U4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw0E4-0001AH-9f
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:54:01 -0500
Date: Tue, 19 Feb 2019 08:53:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219075333.GA4727@localhost.localdomain>
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] Add a gitlab-ci file for
 Continuous Integration testing on Gitlab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

Am 19.02.2019 um 07:44 hat Thomas Huth geschrieben:
> On 18/02/2019 19.22, Cleber Rosa wrote:
> > 
> > 
> > On 2/13/19 6:54 AM, Thomas Huth wrote:
> >> This is very convenient for people like me who store their QEMU git trees
> >> on gitlab.com: Automatic CI pipelines are now run for each branch that is
> >> pushed to the server - useful for some extra-testing before sending PULL-
> >> requests for example. Since the runtime of the jobs is limited to 1h, the
> >> jobs are distributed into multiple pipelines - this way everything finishs
> >> fine within time (ca. 30 minutes currently).
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  An example can be seen here: https://gitlab.com/huth/qemu/pipelines/
> >>
> >>  I'd really like to get this into the main QEMU repository, so that I don't
> >>  have to cherry-pick this patch onto my testing branches anymore each time
> >>  I want to test before sending a PULL request...
> >>
> >>  .gitlab-ci.yml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  MAINTAINERS    |  5 ++++
> >>  2 files changed, 78 insertions(+)
> >>  create mode 100644 .gitlab-ci.yml
> >>
> >> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >> new file mode 100644
> >> index 0000000..79d02cf
> >> --- /dev/null
> >> +++ b/.gitlab-ci.yml
> >> @@ -0,0 +1,73 @@
> >> +before_script:
> >> + - apt-get update -qq
> >> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev genisoimage
> >> +
> >> +build-system1:
> >> + script:
> >> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
> >> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
> >> + - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
> >> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
> >> +      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
> >> + - make -j2
> >> + - make -j2 check
> >> +
> >> +build-system2:
> >> + script:
> >> + - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
> >> +      libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
> >> + - ./configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
> >> +      microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
> >> +      sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
> >> + - make -j2
> >> + - make -j2 check
> >> +
> >> +build-disabled:
> >> + script:
> >> + - ./configure --enable-werror --disable-rdma --disable-slirp --disable-curl
> >> +      --disable-capstone --disable-live-block-migration --disable-glusterfs
> >> +      --disable-replication --disable-coroutine-pool --disable-smartcard
> >> +      --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
> >> +      --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
> >> +      --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
> >> +      --target-list="i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user"
> >> + - make -j2
> >> + - make -j2 check-qtest SPEED=slow
> >> +
> >> +build-tcg-disabled:
> >> + script:
> >> + - apt-get install -y -qq clang libgtk-3-dev libbluetooth-dev libusb-dev
> >> + - ./configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
> >> + - make -j2
> >> + - make check-unit
> >> + - make check-qapi-schema
> >> + - cd tests/qemu-iotests/
> >> + - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
> >> +            052 063 077 086 101 104 106 113 147 148 150 151 152 157 159 160
> >> +            163 170 171 183 184 192 194 197 205 208 215 221 222 226 227 236
> >> + - ./check -qcow2 001 002 003 004 005 007 008 009 010 011 012 013 017 018 019
> >> +            020 021 022 024 025 027 028 029 031 032 033 034 035 036 037 038
> >> +            039 040 042 043 046 047 048 049 050 051 052 053 054 056 057 058
> >> +            060 061 062 063 065 066 067 068 069 071 072 073 074 079 080 082
> >> +            085 086 089 090 091 095 096 097 098 099 102 103 104 105 107 108
> >> +            110 111 114 117 120 122 124 126 127 129 130 132 133 134 137 138
> >> +            139 140 141 142 143 144 145 147 150 151 152 154 155 156 157 158
> >> +            161 165 170 172 174 176 177 179 184 186 187 190 192 194 195 196
> >> +            197 200 202 203 205 208 209 214 215 216 217 218 222 226 227 229 234
> >> +
> > 
> > On the matter of "make check-block" or "./check xxx", I've seen
> > arguments for both sides.  I've sent a similar (but using make
> > check-block) patch for Travis:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02334.html
> > 
> > I'd be nice to hear from the qemu-iotest's maintainers which approach
> > is preferable for upstream + shared computing resources kind of environment.
> 
> I think "make check-block" should likely be the preferred way to run the
> tests for normal builds (and by the way, why don't we always run this
> during "make check" yet?).
> 
> But in this CI file here, I'm running the tests for the "--disable-tcg"
> build - simply because this test finishes way earlier than the other
> tests otherwise. Unfortunately --disable-tcg causes some of the iotests
> to fail - expected, since you also can not use KVM on the CI server, so
> there is no way to execute guest code with this build (e.g. I'm also not
> running the qtests in this pipe). Thus I had to limit the iotests to the
> ones that also work without TCG, i.e. I have to run the check script
> directly here with a list of tests that seem to be working in this
> environment.

qemu-iotests doesn't run any guest code and I think almost all tests
only use the qtest or none machines. We can make sure that the remaining
one or two tests that do need TCG/KVM for some reason are not in 'quick'
group, so that './check -T -qcow2 -g quick' does the right thing (which
is also what 'make check-block' does internally).

Which are the cases that fail for you with '--disable-tcg'?

Kevin
