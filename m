Received: from eggs.gnu.org ([2001:4830:134:3::10]:42927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWxH-0006Q7-2B
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 22:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWxD-0006UR-3L
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 22:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFWxC-0006UA-Rp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 22:04:31 -0500
References: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e9f7aaa0-6b5d-e494-8da0-26bf3f4f6929@redhat.com>
Date: Fri, 17 Nov 2017 11:04:25 +0800
MIME-Version: 1.0
In-Reply-To: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] e1000: Correct TX offload context
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 07:23, Ed Swierk via Qemu-devel wr=
ote:
> The transmit offload implementation in QEMU's e1000 device is
> deficient and causes packet data corruption in some situations.
>
> According to the Intel 8254x software developer's manual[1], the
> device maintains two separate contexts: the TCP segmentation offload
> context includes parameters for both segmentation offload and checksum
> offload, and the normal (checksum-offload-only) context includes only
> checksum offload parameters. These parameters specify over which
> packet data to compute the checksum, and where in the packet to store
> the computed checksum(s).
>
> [1] https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-c=
ontrollers-software-dev-manual.pdf
>
> The e1000 driver can update either of these contexts by sending a
> transmit context descriptor. The TSE bit in the TUCMD field controls
> which context is modified by the descriptor. Crucially, a transmit
> context descriptor with TSE=3D1 changes only the TSO context, leaving
> the non-TSO context unchanged; with TSE=3D0 the opposite is true.
>
> Fields in the transmit data descriptor determine which (if either) of
> these two contexts the device uses when actually transmitting some
> data:
>
> - If the TSE bit in the DCMD field is set, then the device performs
>    TCP segmentation offload using the parameters previously set in the
>    TSO context. In addition, if TXSM and/or IXSM is set in the POPTS
>    field, the device performs the appropriate checksum offloads using
>    the parameters in the same (TSO) context.
>
> - Otherwise, if the TSE bit in the DCMD field is clear, then there is
>    no TCP segmentation offload. If TXSM and/or IXSM is set in the POPTS
>    field, the device performs the appropriate checksum offloads using
>    the parameters in the non-TSO context.
>
> The e1000 driver is free to set up the TSO and non-TSO contexts and
> then transmit a mixture of data, with each data descriptor using a
> different (or neither) context. This is what the e1000 driver for
> Windows (Intel(R) PRO/1000 MT Network Connection, aka E1G6023E.sys)
> does in certain cases. Sometimes with quite undesirable results, since
> the QEMU e1000 device doesn't work as described above.
>
> Instead, the QEMU e1000 device maintains only one context in its state
> structure. When it receives a transmit context descriptor from the
> driver, it overwrites the context parameters regardless of the TSE bit
> in the TUCMD field.
>
> To see why this is wrong, suppose the driver first sets up a non-TSO
> context with UDP checksum offload parameters (say, TUCSO pointing to
> the appropriate offset for a UDP checksum, 6 bytes into the header),
> and then sets up a TSO context with TCP checksum offload parameters
> (TUCSO pointing to the appropriate offset for a TCP checksum, 16 bytes
> into the header). The driver then sends a transmit data descriptor
> with TSO=3D0 and TXSM=3D1 along with a UDP datagram. The QEMU e1000 dev=
ice
> computes the checksum using the last set of checksum offload
> parameters, and writes the checksum to offset 16, stomping on two
> bytes of UDP data, and leaving the wrong checksum in the UDP checksum
> field.
>
> To make matters worse, if the network stack on the host running QEMU
> treats data transmitted from a VM as locally originated, it may do its
> own UDP checksum computation, "correcting" it to match the corrupt
> data before sending it on the wire. Now the corrupt UDP packet makes
> its way all the way to the peer application.
>
> I have reproduced this behavior with a Windows 10 guest, rather easily
> with a TCP iperf and a UDP iperf running in parallel. With the
> patchlet below, you'll see an error message whenever the bug is
> triggered.
>
>
>   --- a/hw/net/e1000.c
>   +++ b/hw/net/e1000.c
>   @@ -534,6 +534,30 @@ e1000_send_packet(E1000State *s, const uint8_t *=
buf, int size)
>    }
>   =20
>    static void
>   +debug_csum(struct e1000_tx *tp, uint16_t oldsum)
>   +{
>   +    e1000x_txd_props *props =3D &tp->props;
>   +    uint8_t proto =3D tp->data[14 + 9];
>   +    uint32_t sumoff =3D props->tucso - props->tucss;
>   +
>   +    if ((proto =3D=3D 17 && sumoff !=3D 6) ||
>   +        (proto =3D=3D 6 && sumoff !=3D 16)) {
>   +        DBGOUT(TXERR, "txsum bug! ver %d src %08x dst %08x len %d pr=
oto %d "
>   +               "cptse %d sum_needed %x oldsum %x newsum %x realsum %=
x\n",
>   +               tp->data[14] >> 4,
>   +               ldl_be_p(tp->data + 14 + 12),
>   +               ldl_be_p(tp->data + 14 + 16),
>   +               lduw_be_p(tp->data + 14 + 2),
>   +               proto,
>   +               props->cptse,
>   +               props->sum_needed,
>   +               oldsum,
>   +               lduw_be_p(tp->data + props->tucso),
>   +               lduw_be_p(tp->data + props->tucss + (proto =3D=3D 6 ?=
 16 : 6)));
>   +    }
>   +}
>   +
>   +static void
>    xmit_seg(E1000State *s)
>    {
>        uint16_t len;
>   @@ -577,8 +601,10 @@ xmit_seg(E1000State *s)
>        }
>   =20
>        if (tp->props.sum_needed & E1000_TXD_POPTS_TXSM) {
>   +        uint16_t oldsum =3D lduw_be_p(tp->data + tp->props.tucso);
>            putsum(tp->data, tp->size, tp->props.tucso,
>                   tp->props.tucss, tp->props.tucse);
>   +        debug_csum(tp, oldsum); /* FIXME: remove */
>        }
>        if (tp->props.sum_needed & E1000_TXD_POPTS_IXSM) {
>            putsum(tp->data, tp->size, tp->props.ipcso,
>
>
> This patch series first moves per-TX packet flags out of the context
> struct, which is used by both e1000 and e1000e. ("Used" is generous,
> as e1000e ignores most of the context parameters supplied by the guest
> and does its own thing, which is only sometimes correct. Taming e1000e
> is a project for another day. The change to e1000e here is a baby step
> in that direction.)
>
> Then we separate the e1000 TSO and non-TSO contexts, which fixes the
> UDP TX corruption bug.
>
> Ed Swierk (2):
>    e1000, e1000e: Move per-packet TX offload flags out of context state
>    e1000: Separate TSO and non-TSO contexts, fixing UDP TX corruption
>
>   hw/net/e1000.c         | 92 ++++++++++++++++++++++++++++-------------=
---------
>   hw/net/e1000e.c        |  4 +--
>   hw/net/e1000e_core.c   | 16 ++++-----
>   hw/net/e1000e_core.h   |  2 ++
>   hw/net/e1000x_common.h |  2 --
>   5 files changed, 64 insertions(+), 52 deletions(-)
>

Consider the risk for rc1, I've queued this for 2.12.

Thanks
