Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elAXB-0002yO-ET
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elAX7-000490-Bx
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:36:25 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elAX7-000488-6k
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:36:21 -0500
Received: by mail-ot0-x244.google.com with SMTP id q9so13456593oti.0
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 01:36:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209190703-mutt-send-email-mst@kernel.org>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
	<20180209190703-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2018 09:35:59 +0000
Message-ID: <CAFEAcA_CL6P31EJyzxom1oh6j8LNDD2+OXjJ65hKsB=zBw6tWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 February 2018 at 17:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Feb 09, 2018 at 10:06:42AM +0000, Peter Maydell wrote:
>> On 8 February 2018 at 19:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c96:
>> >
>> >   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-02-08 14:31:51 +0000)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>> >
>> > for you to fetch changes up to f4ac9b2e04e8d98854a97bc473353207765aa9e7:
>> >
>> >   virtio-balloon: include statistics of disk/file caches (2018-02-08 21:06:42 +0200)
>> >
>> > ----------------------------------------------------------------
>> > virtio,vhost,pci,pc: features, fixes and cleanups
>> >
>> > - a new vhost crypto device
>> > - new stats in virtio balloon
>> > - virtio eventfd rework for boot speedup
>> > - vhost memory rework for boot speedup
>> > - fixes and cleanups all over the place
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>>
>> Hi. This has some format-string issues:

> Fixed up now, new hash d94c5ae38f25a6e77e07007dcd510b7203a687e8

This asserts in 'make check' for NetBSD, FreeBSD, OpenBSD, OSX:

TEST: tests/device-introspect-test... (pid=19530)
  /aarch64/device/introspect/list:                                     OK
  /aarch64/device/introspect/list-fields:                              OK
  /aarch64/device/introspect/none:                                     OK
  /aarch64/device/introspect/abstract:                                 OK
  /aarch64/device/introspect/concrete:                                 **
ERROR:/root/qemu/qom/object.c:372:object_initialize_with_type:
assertion failed: (type != NULL)
Broken pipe
FAIL
GTester: last random seed: R02Sd4e2c04f6ac00d843a31ccac4de0d914
(pid=12686)
  /aarch64/device/introspect/abstract-interfaces:                      OK
FAIL: tests/device-introspect-test

(other archs fail too, aarch64 is just the first one we hit). This
error is often "device A instantiates device B, but device B is
conditionally compiled in and A is always compiled; so test fails
trying to create device A on hosts where device B isn't built" I think.

clang build on x86 fails to compile:
/home/petmay01/linaro/qemu-for-merges/backends/cryptodev-vhost-user.c:86:16:
error: address of array 's->vhost_crypto' will always evaluate to
'true' [-Werror,-Wpointer-bool-conversion]
        if (s->vhost_crypto) {
        ~~  ~~~^~~~~~~~~~~~

thanks
-- PMM
