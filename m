Received: from eggs.gnu.org ([2001:4830:134:3::10]:57191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0WFf-0004A3-7q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0WFb-0004rY-V0
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:17:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0WFb-0004qM-M3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:17:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-19-david@redhat.com>
	<87k20eq9em.fsf@dusky.pond.sub.org>
	<20171004100415.0f0ded10.cohuck@redhat.com>
	<87k20bm6cw.fsf@dusky.pond.sub.org>
	<20171004150956.0901d6c1.cohuck@redhat.com>
Date: Fri, 06 Oct 2017 19:17:20 +0200
In-Reply-To: <20171004150956.0901d6c1.cohuck@redhat.com> (Cornelia Huck's
	message of "Wed, 4 Oct 2017 15:09:56 +0200")
Message-ID: <87wp48xkkf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 18/22] s390x: implement
 query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, 04 Oct 2017 14:42:55 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Cornelia Huck <cohuck@redhat.com> writes:
>>=20
>> > On Mon, 02 Oct 2017 09:46:41 +0200
>> > Markus Armbruster <armbru@redhat.com> wrote:
>> >=20=20
>> >> David Hildenbrand <david@redhat.com> writes:
>> >>=20=20=20
>> >> > CPU hotplug is only possible on a per core basis on s390x. So let's
>> >> > add possible_cpus and properly wire everything up.
>> >> >
>> >> > Signed-off-by: David Hildenbrand <david@redhat.com>=20=20=20=20
>> >> [...]=20=20
>> >> > diff --git a/qapi-schema.json b/qapi-schema.json
>> >> > index f3af2cb851..79e9f85404 100644
>> >> > --- a/qapi-schema.json
>> >> > +++ b/qapi-schema.json
>> >> > @@ -3121,6 +3121,22 @@
>> >> >  #      }
>> >> >  #    ]}
>> >> >  #
>> >> > +# For s390x-virtio-ccw machine type started with -smp 1,maxcpus=3D=
2 -cpu qemu
>> >> > +# (Since: 2.11):
>> >> > +#
>> >> > +# -> { "execute": "query-hotpluggable-cpus" }
>> >> > +# <- {"return": [
>> >> > +#      {
>> >> > +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
>> >> > +#         "props": { "core-id": 1 }
>> >> > +#      },
>> >> > +#      {
>> >> > +#         "qom-path": "/machine/unattached/device[0]",
>> >> > +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
>> >> > +#         "props": { "core-id": 0 }
>> >> > +#      }
>> >> > +#    ]}
>> >> > +#
>> >> >  ##
>> >> >  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableC=
PU'] }=20=20=20=20
>> >>=20
>> >> Please stick in '# Example:' like we do in query-hotpluggable-cpus's =
doc
>> >> comment.  I expect the generated documentation to be illegible[*]
>> >> without it.=20=20
>> >
>> > Should '# Example:' go before each of the examples (instead of the
>> > beginning of the example block), then?=20=20
>>=20
>> Whatever makes the generated documentation look better.
>
> The pdf indeed looks ugly, but that's a preexisting problem, and adding
> more '# Example:' lines does not really help.
>
> The basic issue is that the code expects just one example and no
> additional text for the '# Example:' tag -- the explaining text for the
> various statements ends up looking like the qmp examples. That should
> be improved before doing a patch on top for this command (and I don't
> really have the skills or time to improve the output, sorry.)

Marc-Andr=C3=A9, any ideas?
