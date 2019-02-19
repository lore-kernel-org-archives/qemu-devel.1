Received: from eggs.gnu.org ([209.51.188.92]:37656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvzwI-0002GW-34
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvzwH-0002Fn-0J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gvzwG-0002FA-Jg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:35:36 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a5501e00-7b1d-9871-fbc8-850b735739bf@redhat.com>
Date: Tue, 19 Feb 2019 15:35:25 +0800
MIME-Version: 1.0
In-Reply-To: <1550118402-4057-1-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/11] packed ring virtio-net backends
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com


On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> https://github.com/Whishay/qemu.git
>
> Userspace and vhost-net backend test has been done with upstream kernel
> in guest.
>
> v3->v4:
>      - add version number to the subject of each patch.(mst)
>
> v2->v3:
>      v2/01 - drop it since the header has been synchronized from kernel=
.(mst & jason)
>      v3/01 - rename 'avail_wrap_counter' to 'last_avail_wrap_counter',
>              'event_wrap_counter' to 'avail_wrap_counter' to make it ea=
sier
>              to understand.(Jason)
>            - revise commit message.(Jason)
>      v3/02 - split packed ring areas size calculation to next patch.(Ja=
son)
>              to not break bisect(Jason).
>      v3/03 - initialize packed ring region with correct size and attrib=
ute.
>            - remove unnecessary 'else' checks. (Jason)
>      v3/06 - add commit log.
>            - replace 'event_wrap-counter' with 'avail_wrap_counter'.
>            - merge common memory cache size check to virtqueue_get_avai=
l_bytes().(Jason)
>            - revise memory barrier comment.(Jason)
>            - check indirect descriptors by desc.len/sizeof(desc).(Jason=
)
>            - flip wrap counter with '^=3D1'.(Jason)
>      v3/07 - move desc.id/len initialization to the declaration.(Jason)
>            - flip wrap counter '!' with '^=3D1'.(Jason)
>            - add memory barrier comments in commit message.
>      v3/08 - use offsetof() when writing cache.(Jason)
>            - avoid duplicated memory region write when turning off even=
t_idx
>              supported notification.(Jason)
>            - add commit log.(Jason)
>            - add avail & last_avail wrap counter difference description=
 in commit log.
>      v3/09 - remove unnecessary used/avail idx/wrap-counter from subsec=
tion.
>            - put new subsection to the end of vmstate_virtio.(Jason)
>            - squash the two userspace and vhost-net migration patches i=
n v2.(Jason)
>      v3/10 - reword commit message.
>            - this is a help not a bug fix so I would like to keep it as=
 a
>              separate patch still.(Proposed a merge it by Jason)
>            - the virtqueue_fill() is also not like an API so I would pr=
efer not
>              to touch it, please correct me if I did not get it in the =
right
>              way.(Proposed a squash by Jason)
>      v3/11 - squash feature bits for user space and vhost kernel/user b=
ackends.
>            - enable packed ring feature bit provision on host by defaul=
t.(Jason)
>
> Wei Xu (11):
>    virtio: rename structure for packed ring
>    virtio: device/driver area size calculation helper for split ring
>    virtio: initialize packed ring region
>    virtio: initialize wrap counter for packed ring
>    virtio: queue/descriptor check helpers for packed ring
>    virtio: get avail bytes check for packed ring
>    virtio: fill/flush/pop for packed ring
>    virtio: event suppression support for packed ring
>    virtio-net: update the head descriptor in a chain lastly
>    virtio: migration support for packed ring
>    virtio: CLI and provide packed ring feature bit by default
>
>   hw/net/vhost_net.c         |   2 +
>   hw/net/virtio-net.c        |  11 +-
>   hw/virtio/virtio.c         | 798 ++++++++++++++++++++++++++++++++++++=
+++++----
>   include/hw/virtio/virtio.h |   4 +-
>   4 files changed, 757 insertions(+), 58 deletions(-)


Looks like there's something missed in the series. e.g the support of:

virtqueue_unpop()

virtqueue_rewind()

Thanks
