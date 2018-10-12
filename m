Received: from eggs.gnu.org ([2001:4830:134:3::10]:41364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAtts-0008NK-88
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAttn-0001N8-HI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gAttl-0001LC-11
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:38:22 -0400
Date: Fri, 12 Oct 2018 10:37:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181012093757.GT16720@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011154834.GA10122@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Changpeng Liu <changpeng.liu@intel.com>

On Thu, Oct 11, 2018 at 04:48:34PM +0100, Daniel P. Berrang=C3=A9 wrote:
> Adding Markus since we're talking about new CLI argument and capability
> reporting standards.
>=20
> On Fri, Sep 14, 2018 at 05:52:30PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> > review, let's define a common set of backend conventions to help with
> > management layer implementation, and interoperability.
> >=20
> > v2:
> >  - drop --pidfile
> >  - add some notes about daemonizing & stdin/out/err
> >=20
> > Cc: libvir-list@redhat.com
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Felipe Franciosi <felipe@nutanix.com>
> > Cc: Gonglei <arei.gonglei@huawei.com>
> > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Victor Kaplansky <victork@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/interop/vhost-user.txt | 109 ++++++++++++++++++++++++++++++++++=
+-
> >  1 file changed, 107 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.tx=
t
> > index ba5e37d714..339b335e9c 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -17,8 +17,13 @@ The protocol defines 2 sides of the communication,=
 master and slave. Master is
> >  the application that shares its virtqueues, in our case QEMU. Slave =
is the
> >  consumer of the virtqueues.
> > =20
> > -In the current implementation QEMU is the Master, and the Slave is i=
ntended to
> > -be a software Ethernet switch running in user space, such as Snabbsw=
itch.
> > +In the current implementation QEMU is the Master, and the Slave is t=
he
> > +external process consuming the virtio queues, for example a software
> > +Ethernet switch running in user space, such as Snabbswitch, or a blo=
ck
> > +device backend processing read & write to a virtual disk. In order t=
o
> > +facilitate interoperability between various backend implementations,
> > +it is recommended to follow the "Backend program conventions"
> > +described in this document.
> > =20
> >  Master and slave can be either a client (i.e. connecting) or server =
(listening)
> >  in the socket communication.
> > @@ -859,3 +864,103 @@ resilient for selective requests.
> >  For the message types that already solicit a reply from the client, =
the
> >  presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being =
set brings
> >  no behavioural change. (See the 'Communication' section for details.=
)
> > +
> > +Backend program conventions
> > +---------------------------
> > +
> > +vhost-user backends provide various services and they may need to be
> > +configured manually depending on the use case. However, it is a good
> > +idea to follow the conventions listed here when possible. Users, QEM=
U
> > +or libvirt, can then rely on some common behaviour to avoid
> > +heterogenous configuration and management of the backend program and
> > +facilitate interoperability.
> > +
> > +In order to be discoverable, default vhost-user backends should be
> > +located under "/usr/libexec", and be named "vhost-user-$device" wher=
e
> > +"$device" is the device name in lower-case following the name listed
> > +in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERIAL
> > +backend would be named "vhost-user-rproc-serial").
> > +
> > +Mechanisms to list, and to select among alternatives implementations
> > +or modify the default backend are not described at this point (a
> > +distribution may use update-alternatives, for example, to list and t=
o
> > +pick a different default backend).
>=20
> I don't think that update-alternatives is a good thing as it presumes
> that each host only needs a single preferred impl at a time.
>=20
> I think we need to be able to discover all impls for a given device
> type.
>=20
> This feels like the same problem we tackled recently with enumerating
> and choosing between multiple firmware impls.
>=20
> In $git/docs/interop/firmware.json we defined a way to drop config file=
s
> into a standard directory, providing info about the firmware in a well
> defined QAPI based data format.
>=20
> Rather than requiring a special file naming convention I think we just
> need to register config files in a particular directory, letting the
> mgmt app enumerate them.
>=20
> eg
>=20
>   /etc/qemu/vhost-user/50-rproc-serial.json  (a default imp from QEMU)
>   /etc/qemu/vhost-user/10-my-rproc-serial.json (my replacenment impl)
>=20
> a file could be something pretty simple like
>=20
>    {
>        "name": "my-rproc-serial",
>        "description": "My rproc serial impl doing foo, bar, wizz",
>        "device": "rproc-serial",
>        "binary": "/usr/libexec/my-awesome-rproc-serial",
>    }
>=20
> Mgmt apps can simply load all files in that directory to learn about
> the possible impls. The file load order gives a prioritization if
> multiple matches exist, or a specific impl can be requested by
> name "my-rproc-serial".
>=20
> This shouldn't provide full capabilities reporting though, just
> enough to identify viable binaries. Capabilities should still be
> via the binary itself so it can be dynamically tailored based on
> other environmental factors
>=20
> > +
> > +The backend program must not daemonize itself, but it may be
> > +daemonized by the management layer. It may also have a restricted
> > +access to the system.
> > +
> > +File descriptors 0, 1 and 2 will exist, and have regular
> > +stdin/stdout/stderr usage (they may be redirected to /dev/null by th=
e
> > +management layer, or to a log handler).
> > +
> > +The backend program must end (as quickly and cleanly as possible) wh=
en
> > +the SIGTERM signal is received. Eventually, it may be SIGKILL by the
> > +management layer after a few seconds.
> > +
> > +The following command line options have an expected behaviour. They
> > +are mandatory, unless explicitly said differently:
> > +
> > +* --socket-path=3DPATH
> > +
> > +This option specify the location of the vhost-user Unix domain socke=
t.
> > +It is incompatible with --fd.
> > +
> > +* --fd=3DFDNUM
> > +
> > +When this argument is given, the backend program is started with the
> > +vhost-user socket as file descriptor FDNUM. It is incompatible with
> > +--socket-path.
> > +
> > +* --print-capabilities
> > +
> > +Output to stdout a line-seperated list of backend capabilities, and
> > +then exit successfully. Other options and arguments should be ignore=
d,
> > +and the backend program should not perform its normal function.
>=20
> This is going to repeat the mistakes we've had with every other
> binary in QEMU. A "simple" flag list or args sounds appealing,
> but we've always been burnt by it in the medium-long term, which
> is why we created QAPI.
>=20
> If we're doing to have any capabilities reporting, we should
> model it in QAPI schema, so any '--print-capabilities' arg
> should print a JSON doc following the documented schema.
>=20
> While talking about QAPI, I think this is an opportunity to
> also avoid the problems of CLI arg values becoming more
> complex than just scalars. eg
>=20
>   --socket-path=3DPATH
>=20
> may inevitably grow more options  - eg to perhaps say whether
> to use it in listen or connect mode. Or to indicate a reconnect
> timeout. etc
>=20
> I know Markus wants to replace QemuOpts with something that
> is again driven by QAPI, so that "-arg $VALUE" can handle
> $VALUE being complex  non-scalar data following a QAPI
> schema with well defined semantics for parsing. Since we
> are defining a new standard, I think we should go todo
> something better than scalar values right from the start.
>=20
> > +
> > +At the time of writing, there are no common capabilities. Some
> > +device-specific capabilities are listed in the respective sections. =
By
> > +convention, device-specific capabilities are prefixed by their devic=
e
> > +name.
> > +
> > +vhost-user-input program conventions
> > +------------------------------------
> > +
> > +Capabilities:
> > +
> > +input-evdev-path
> > +
> > +    The --evdev-path command line option is supported.
> > +
> > +input-no-grab
> > +
> > +    The --no-grab command line option is supported.
> > +
> > +* --evdev-path=3DPATH (optional)
> > +
> > +Specify the linux input device.
> > +
> > +* --no-grab (optional)
> > +
> > +Do no request exclusive access to the input device.
> > +
> > +vhost-user-gpu program conventions
> > +----------------------------------
> > +
> > +Capabilities:
> > +
> > +gpu-render-node
> > +
> > +    The --render-node command line option is supported.
> > +
> > +gpu-virgl
> > +
> > +    The --virgl command line option is supported.
> > +
> > +* --render-node=3DPATH (optional)
> > +
> > +Specify the GPU DRM render node.
> > +
> > +* --virgl (optional)
> > +
> > +Enable virgl rendering support.

As a rough illustration I mocked up a possible QAPI schema that covers
the templates describing the binaries, the format of CLI arguments, and
the data for capabilities.

Note, I can't remember what Markus had proposed for CLI arguments in
QAPI, so I invented something arbitary but plausible.



#
# The type of device the vhost-user backend is for
#
{ 'enum': 'VHostUserBackendType',
  'data': 'input', 'gpu', ... }


#
# @type: the type of backend interface provided
# @name: short name of the impl, unique wrt @type
# @description: a human-readable description of the firmware.
# @binary: fully qualified path to the binary
#
{
    'struct': 'VHostUserBackend',
    'data': {
	'type': 'VHostUserBackendType',
	'name': 'str'
	'description': 'str'
	'binary': 'str'
    }
}



#
# Command line options common to all vhost user backends
#
{
    'optionset': 'VHostUserBackendCommandLineBase',
    'data': [
	{
	    'option': '--print-capabilities',
            'help': 'Print backend capabilities document',
	},
	{
	    'option': '--socket',
	    'data': 'ChardevSocket',
	    'help': 'Socket to communicate with frontend',
	},
    ]
}


#
# Command line options for vhost user "input" backends
#
{
    'optionset': 'VHostUserBackendCommandLineInput',
    'base': 'VHostUserBackendCommandLineBase',
    'data': [
	{
	    'option': '--evdev-path',
	    'data': 'str',
            'help': 'The Linux input device path',
	},
	{
	    'option': '--no-grab',
	    'data': 'str',
	    'help': 'Do not request exclusive access to device',
	},
    ]
}


#
# Command line options for vhost user "gpu" backends
#
{
    'optionset': 'VHostUserBackendCommandLineGPU',
    'base': 'VHostUserBackendCommandLineBase',
    'data': [
	{
	    'option': '--render-node',
	    'data': 'str',
            'help': 'The GPU DRM render node path',
	},
	{
	    'option': '--virgl',
	    'help': 'Enable virgl rendering support',
	},
    ]
}


#
# Command line options for vhost user backends
#
{
    'union': 'VHostUserBackendCommandLine',
    'base': { 'type': 'VHostUserBackendType' },
    'discriminator': 'type',
    'data': {
	'input': 'VHostUserBackendCommandLineInput',
	'gpu': 'VHostUserBackendCommandLineGPU',
    }
}


{
    'enum': 'VHostUserBackendInputFeature',
    'data': { 'evdev-path', 'no-grab', }
}

#
# Capabilities reported by vhost user "input" backends
#
{
    'struct': 'VHostUserBackendCapabilitiesInput',
    'data': {
        'features': [ 'VHostUserBackendInputFeature' ],
    }
}



{
    'enum': 'VHostUserBackendGPUFeature',
    'data': { 'render-node', 'virgl' }
}


#
# Capabilities reported by vhost user "gpu" backends
#
{
    'struct': 'VHostUserBackendCapabilitiesGPU',
    'data': {
        'features': [ 'VHostUserBackendGPUFeature' ],
    }
}


#
# Capabilities reported by vhost user backends
#
{
    'union': 'VHostUserBackendCapabilities',
    'base': { 'type': 'VHostUserBackendType' },
    'discriminator': 'type',
    'data': {
	'input': 'VHostUserBackendCapabilitiesInput',
	'gpu': 'VHostUserBackendCapabilitiesGPU',
    }
}



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
