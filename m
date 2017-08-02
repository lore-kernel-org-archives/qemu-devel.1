Received: from eggs.gnu.org ([2001:4830:134:3::10]:47125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dcu2v-00006G-9n
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dcu2s-0007FJ-4r
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:50:45 -0400
References: <20170802103259.25940-1-lvivier@redhat.com>
	<CAAdtpL4fDx3JLm7+=TcJTZXwq_zuwup4=zkGH8QMLJ1ES=kqHw@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <de5b3384-086b-bf7f-944f-94d10e185a7d@redhat.com>
Date: Wed, 2 Aug 2017 15:50:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4fDx3JLm7+=TcJTZXwq_zuwup4=zkGH8QMLJ1ES=kqHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 02/08/2017 15:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laurent,
>=20
> On Wed, Aug 2, 2017 at 7:32 AM, Laurent Vivier <lvivier@redhat.com> wro=
te:
>> With pseries machine type a negative core-id is not managed properly:
>> -1 gives an inaccurate error message ("core -1 already populated"),
>> -2 crashes QEMU (core dump)
>>
>> As it seems a negative value is invalid for any architecture,
>> instead of checking this in spapr_core_pre_plug() I think it's better
>> to check this in the generic part, core_prop_set_core_id()
>=20
> Why is this property signed? If there is not reason to use it negative,
> is it possible to use object_property_add(.."uint"..)?

You should be right:

{ 'struct': 'NumaNodeOptions',
  'data': {
   '*nodeid': 'uint16',
   '*cpus':   ['uint16'],
   '*mem':    'size',
   '*memdev': 'str' }}

but

{ 'struct': 'CpuInstanceProperties',
  'data': { '*node-id': 'int',
            '*socket-id': 'int',
            '*core-id': 'int',
            '*thread-id': 'int'
  }
}

But I'm not sure it's a good idea to change the API now.

> Also what about core_prop_set_nr_threads()? It might coredump the
> same way.

In pseries case, there is another test in the spapr part that prevents th=
at.

Thanks,
Laurent
