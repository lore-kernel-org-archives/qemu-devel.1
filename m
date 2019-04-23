Received: from eggs.gnu.org ([209.51.188.92]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJ16X-0001YT-B6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJ16V-0003Bv-UP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hJ16T-00030e-Ru
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:29:19 -0400
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20190329210804.22121-1-wainersm@redhat.com>
Message-ID: <5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
Date: Tue, 23 Apr 2019 16:28:59 -0300
MIME-Version: 1.0
In-Reply-To: <20190329210804.22121-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: Python 3,
 improve image caching, and misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, philmd@redhat.com, lersek@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org

Ping. More reviews needed.

I've already got Philippe's reviewed-by, thanks!

- Wainer


On 03/29/2019 06:07 PM, Wainer dos Santos Moschetta wrote:
> Hi all!
>
> This series bundles the support to Python3, improvement to image caching, and miscellaneous changes for the vm-test (`make vm-build-*`).
>
> Git tree: http://github.com/wainersm/qemu
> Branch: vm_test_python3_and_misc
> Travis: https://travis-ci.org/wainersm/qemu/builds/513220300
>
> Below you can find some general comments.
>
> Patch 01:
> Uses python configured at build, although vm-test can be executed from the code tree (see docs/devel/testing.rst) too. In this case $(PYTHON) will be empty and it picks python pointed by the script's shebang, as a result failing on Python 3 only Linux distros.
>
> Patch 02:
> Ported based.py to work with Python 3 (kept Python 2 compatibility). Fixed the follow errors:
>    - Raising "TypeError: Unicode-objects must be encoded before hashing" exception by hashlib.sha1().
>    - get_default_jobs() is used to set the vm cpus, but it was returning an invalid float number.
>    - On check_sha256sum(), subprocess.check_output() returns bytes so that string comparison was failing.
>
> Patch 03:
> Implemented a simple mechanism to detect the image file changed on http://download.patchew.org, as discussed in https://www.mail-archive.com/qemu-devel@nongnu.org/msg607839.html. I didn't implement the '--force' option that Paolo suggested, because it would require a major refactoring (technically the vm implementation decides whether use the cache or not). My intention is to keep the script as simple as possible, so IMO, if the image file changed on the server then it should equally be updated the checksum on QEMU's side.
>
> Patch 04:
> Default network (NETWORK=1) backend is enough to have the docker-based tests run properly. Note: `make docker-test-block@centos7` is broken inside the CentOS VM and apparently on my host (Fedora 29 x86_64) too.
>
> Wainer dos Santos Moschetta (5):
>    tests/vm: Use python configured on build
>    tests/vm: Port basevm to Python 3
>    tests/vm: Detect the image changed on server
>    tests/vm: Fix build-centos docker-based tests run
>    tests/vm: Add missing variables on help
>
>   tests/vm/Makefile.include | 12 ++++++++----
>   tests/vm/basevm.py        | 39 ++++++++++++++++++++++++++++++++++-----
>   tests/vm/centos           |  6 +++---
>   3 files changed, 45 insertions(+), 12 deletions(-)
>
