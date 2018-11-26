Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gRGZu-0007Z9-46
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gRGZn-0001A8-Cs
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:05:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gRGZn-00019V-1h
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:05:23 -0500
Date: Mon, 26 Nov 2018 15:05:08 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181126130507.GA9218@lap1>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-25-yuval.shaia@oracle.com>
	<8b89bfaf-be29-e043-32fa-9615fb4ea0f7@gmail.com>
	<25d71e93-c1ab-01c3-8f6c-145606d11a84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <25d71e93-c1ab-01c3-8f6c-145606d11a84@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 24/24] docs: Update pvrdma device
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com, yuval.shaia@oracle.com

On Mon, Nov 26, 2018 at 12:34:41PM +0200, Marcel Apfelbaum wrote:
> Re-sending the comments, some of the recipients didn't get it,
>=20
> Thanks,
> Marcel
>=20
> On 11/25/18 9:51 AM, Marcel Apfelbaum wrote:
> >=20
> >=20
> > On 11/22/18 2:14 PM, Yuval Shaia wrote:
> > > Interface with the device is changed with the addition of support f=
or
> > > MAD packets.
> > > Adjust documentation accordingly.
> > >=20
> > > While there fix a minor mistake which may lead to think that there =
is a
> > > relation between using RXE on host and the compatibility with bare-=
metal
> > > peers.
> > >=20
> > > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > > ---
> > > =A0 docs/pvrdma.txt | 103 +++++++++++++++++++++++++++++++++++++++--=
-------
> > > =A0 1 file changed, 84 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
> > > index 5599318159..f82b2a69d2 100644
> > > --- a/docs/pvrdma.txt
> > > +++ b/docs/pvrdma.txt
> > > @@ -9,8 +9,9 @@ It works with its Linux Kernel driver AS IS, no nee=
d
> > > for any special guest
> > > =A0 modifications.
> > > =A0 =A0 While it complies with the VMware device, it can also
> > > communicate with bare
> > > -metal RDMA-enabled machines and does not require an RDMA HCA in th=
e
> > > host, it
> > > -can work with Soft-RoCE (rxe).
> > > +metal RDMA-enabled machines as peers.
> > > +
> > > +It does not require an RDMA HCA in the host, it can work with
> > > Soft-RoCE (rxe).
> > > =A0 =A0 It does not require the whole guest RAM to be pinned allowi=
ng memory
> > > =A0 over-commit and, even if not implemented yet, migration support
> > > will be
> > > @@ -78,29 +79,93 @@ the required RDMA libraries.
> > > =A0 =A0 3. Usage
> > > =A0 =3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +
> > > +3.1 VM Memory settings
> > > +=3D=3D=3D=3D=3D=3D+++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =A0 Currently the device is working only with memory backed RAM
> > > =A0 and it must be mark as "shared":
> > > =A0=A0=A0=A0 -m 1G \
> > > =A0=A0=A0=A0 -object memory-backend-ram,id=3Dmb1,size=3D1G,share \
> > > =A0=A0=A0=A0 -numa node,memdev=3Dmb1 \
> > > =A0 -The pvrdma device is composed of two functions:
> > > - - Function 0 is a vmxnet Ethernet Device which is redundant in Gu=
est
> > > -=A0=A0 but is required to pass the ibdevice GID using its MAC.
> > > -=A0=A0 Examples:
> > > -=A0=A0=A0=A0 For an rxe backend using eth0 interface it will use i=
ts mac:
> > > -=A0=A0=A0=A0=A0=A0 -device vmxnet3,addr=3D<slot>.0,multifunction=3D=
on,mac=3D<eth0 MAC>
> > > -=A0=A0=A0=A0 For an SRIOV VF, we take the Ethernet Interface expos=
ed by it:
> > > -=A0=A0=A0=A0=A0=A0 -device vmxnet3,multifunction=3Don,mac=3D<RoCE =
eth MAC>
> > > - - Function 1 is the actual device:
> > > -=A0=A0=A0=A0=A0=A0 -device pvrdma,addr=3D<slot>.1,backend-dev=3D<i=
bdevice>,backend-gid-idx=3D<gid>,backend-port=3D<port>
> > > -=A0=A0 where the ibdevice can be rxe or RDMA VF (e.g. mlx5_4)
> > > - Note: Pay special attention that the GID at backend-gid-idx
> > > matches vmxnet's MAC.
> > > - The rules of conversion are part of the RoCE spec, but since
> > > manual conversion
> > > - is not required, spotting problems is not hard:
> > > -=A0=A0=A0 Example: GID: fe80:0000:0000:0000:7efe:90ff:fecb:743a
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MAC: 7c:fe:90:cb:74:3a
> > > -=A0=A0=A0 Note the difference between the first byte of the MAC an=
d the GID.
> > > +
> > > +3.2 MAD Multiplexer
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +MAD Multiplexer is a service that exposes MAD-like interface for V=
Ms in
> > > +order to overcome the limitation where only single entity can
> > > register with
> > > +MAD layer to send and receive RDMA-CM MAD packets.
> > > +
> > > +To build rdmacm-mux run
> > > +# make rdmacm-mux
> > > +
> > > +The application accepts 3 command line arguments and exposes a UNI=
X
> > > socket
> > > +to pass control and data to it.
> > > +-s unix-socket-path=A0=A0 Path to unix socket to listen on
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (d=
efault /var/run/rdmacm-mux)
> > > +-d rdma-device-name=A0=A0 Name of RDMA device to register with
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (d=
efault rxe0)
> >=20
> > I would not default it to rxe0, but request to specify a RDMA interfa=
ce.
> > One can think the multiplexer may select the best available device
> > and finish with an rxe instance instead of a bare-metal one...

Done.

> >=20
> > > +-p rdma-device-port=A0=A0 Port number of RDMA device to register w=
ith
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (d=
efault 1)
> > > +The final UNIX socket file name is a concatenation of the 3
> > > arguments so
> > > +for example for device mlx5_0 on port 2 this
> > > /var/run/rdmacm-mux-mlx5_0-2
> > > +will be created.
> > > +
> > > +Please refer to contrib/rdmacm-mux for more details.
> > > +
> > > +
> > > +3.3 PCI devices settings
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > +RoCE device exposes two functions - an Ethernet and RDMA.
> > > +To support it, pvrdma device is composed of two PCI functions, an
> > > Ethernet
> > > +device of type vmxnet3 on PCI slot 0 and a PVRDMA device on PCI
> > > slot 1. The
> > > +Ethernet function can be used for other Ethernet purposes such as =
IP.
> >=20
> > Nice !
> >=20
> > > +
> > > +
> > > +3.4 Device parameters
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +- netdev: Specifies the Ethernet device on host. For Soft-RoCE
> > > (rxe) this
> > > +=A0 would be the Ethernet device used to create it. For any other
> > > physical
> > > +=A0 RoCE device this would be the netdev name of the device.
> >=20
> > I don't fully understand the above explanation. Can you elaborate
> > or give an exmaple?

How about this:
- netdev: Specifies the Ethernet device function name on the host for
  example enp175s0f0. For Soft-RoCE device (rxe) this would be the Ethern=
et
  device used to create it.

> >=20
> > > +- ibdev: The IB device name on host for example rxe0, mlx5_0 etc.
> > > +- mad-chardev: The name of the MAD multiplexer char device.
> > > +- ibport: In case of multi-port device (such as Mellanox's HCA) th=
is
> > > +=A0 specify the port to use. If not set 1 will be used.
> > > +- dev-caps-max-mr-size: The maximum size of MR.
> > > +- dev-caps-max-qp: Maximum number of QPs.
> > > +- dev-caps-max-sge: Maximum number of SGE elements in WR.
> > > +- dev-caps-max-cq: Maximum number of CQs.
> > > +- dev-caps-max-mr: Maximum number of MRs.
> > > +- dev-caps-max-pd: Maximum number of PDs.
> > > +- dev-caps-max-ah: Maximum number of AHs.
> > > +
> > > +Notes:
> > > +- The first 3 parameters are mandatory settings, the rest have the=
ir
> > > +=A0 defaults.
> > > +- The last 8 parameters (the ones that prefixed by dev-caps)
> > > defines the top
> > > +=A0 limits but the final values is adjusted by the backend device
> > > limitations.
> > > +
> > > +3.5 Example
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Define bridge device with vmxnet3 network backend:
> > > +<interface type=3D'bridge'>
> > > +=A0 <mac address=3D'56:b4:44:e9:62:dc'/>
> > > +=A0 <source bridge=3D'bridge1'/>
> > > +=A0 <model type=3D'vmxnet3'/>
> > > +=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0=
x10'
> > > function=3D'0x0' multifunction=3D'on'/>
> > > +</interface>
> > > +
> > > +Define pvrdma device:
> > > +<qemu:commandline>
> > > +=A0 <qemu:arg value=3D'-object'/>
> > > +=A0 <qemu:arg value=3D'memory-backend-ram,id=3Dmb1,size=3D1G,share=
'/>
> > > +=A0 <qemu:arg value=3D'-numa'/>
> > > +=A0 <qemu:arg value=3D'node,memdev=3Dmb1'/>
> > > +=A0 <qemu:arg value=3D'-chardev'/>
> > > +=A0 <qemu:arg value=3D'socket,path=3D/var/run/rdmacm-mux-rxe0-1,id=
=3Dmads'/>
> > > +=A0 <qemu:arg value=3D'-device'/>
> > > +=A0 <qemu:arg
> > > value=3D'pvrdma,addr=3D10.1,ibdev=3Drxe0,netdev=3Dbridge0,mad-chard=
ev=3Dmads'/>
> > > +</qemu:commandline>
> >=20
> > Please be sure to emphasize that the pvrdma works only
> > if the QEMU is operated by libvirt. The same about the multiplexer.

Added this:

3.3 Service exposed by libvirt daemon
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The control over the RDMA device's GID table is done by updating the
device's Ethernet function addresses.
Usually the first GID entry is determined by the MAC address, the second =
by
the first IPv6 address and the third by the IPv4 address. Other entries c=
an
be added by adding more IP addresses. The opposite is the same, i.e.
whenever an address is removed, the corresponding GID entry is removed.
The process is done by the network and RDMA stacks. Whenever an address i=
s
added the ib_core driver is notified and calls the device driver add_gid
function which in turn update the device.
To support this in pvrdma device the device hooks into the create_bind an=
d
destroy_bind HW commands triggered by pvrdma driver in guest.

Whenever changed is made to the pvrdma port's GID table a special QMP
messages is sent to be processed by libvirt to update the address of the
backend Ethernet device.

pvrdma requires that libvirt service will be up.

> >=20
> > Thanks,
> > Marcel
> >=20
> >=20
>=20
