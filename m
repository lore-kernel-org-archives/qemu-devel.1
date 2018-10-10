Received: from eggs.gnu.org ([2001:4830:134:3::10]:53790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAE5N-0002d7-Gj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAE5J-00075c-Cb
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gAE5H-00074L-F9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:59:27 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-7-crosa@redhat.com>
	<f1fcec57-e7a6-378f-3d8e-88d4976634c0@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <90c45373-fb9e-e3a6-78a9-65538c57068c@redhat.com>
Date: Wed, 10 Oct 2018 08:59:11 -0400
MIME-Version: 1.0
In-Reply-To: <f1fcec57-e7a6-378f-3d8e-88d4976634c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On 10/10/18 6:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 10/10/2018 01:26, Cleber Rosa wrote:
>> One of the Avocado features relevant to virtualization testing is the
>> ability to reuse tests in different scenarios, known as variants.
>> This adds a JSON based variants file, that can be used to run most
>> tests in a number of different architectures.  It can be run with:
>>
>>    $ avocado run \
>>      --json-variants-load=3Dtests/acceptance/variants/arch.json \
>>      --filter-by-tags=3D'-x86_64' -- tests/acceptance/
>>
>> Currently this covers 5 architectures, resulting in the execution
>> of 25 different combinations.
>=20
> Can you provide here the command you used to generate this JSON?
>=20

Yep, there are many ways to do it, one is to have the
varianter-yaml-to-mux plugin installed, and create a YAML file such as:

---- archs.yaml START -----
!mux
x86_64:
  arch: x86_64
aarch64:
  arch: aarch64
ppc64:
  arch: ppc64
ppc:
  arch: ppc
s390x:
  arch: s390x
---- archs.yaml END -----

And run:

 $ avocado run -m archs.yaml -- /bin/true
 $ python -m json.tool ~/avocado/job-results/latest/jobdata/variants.json

I did tweak the "variant_id" value of the resulting JSON file, because
the hashes are somewhat specific to yaml-to-mux, and don't add anything
to the meaning of the variants.

- Cleber.

> Thanks,
>=20
> Phil.
>=20
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/variants/arch.json | 92 ++++++++++++++++++++++++++++=
+
>>  1 file changed, 92 insertions(+)
>>  create mode 100644 tests/acceptance/variants/arch.json
>>
>> diff --git a/tests/acceptance/variants/arch.json b/tests/acceptance/va=
riants/arch.json
>> new file mode 100644
>> index 0000000000..64ff6ad278
>> --- /dev/null
>> +++ b/tests/acceptance/variants/arch.json
>> @@ -0,0 +1,92 @@
>> +[
>> +    {
>> +        "paths": [
>> +            "/run/*"
>> +        ],
>> +        "variant": [
>> +            [
>> +                "/run/aarch64",
>> +                [
>> +                    [
>> +                        "/run/aarch64",
>> +                        "arch",
>> +                        "aarch64"
>> +                    ]
>> +                ]
>> +            ]
>> +        ],
>> +        "variant_id": "aarch64"
>> +    },
>> +    {
>> +        "paths": [
>> +            "/run/*"
>> +        ],
>> +        "variant": [
>> +            [
>> +                "/run/ppc",
>> +                [
>> +                    [
>> +                        "/run/ppc",
>> +                        "arch",
>> +                        "ppc"
>> +                    ]
>> +                ]
>> +            ]
>> +        ],
>> +        "variant_id": "ppc"
>> +    },
>> +    {
>> +        "paths": [
>> +            "/run/*"
>> +        ],
>> +        "variant": [
>> +            [
>> +                "/run/ppc64",
>> +                [
>> +                    [
>> +                        "/run/ppc64",
>> +                        "arch",
>> +                        "ppc64"
>> +                    ]
>> +                ]
>> +            ]
>> +        ],
>> +        "variant_id": "ppc64"
>> +    },
>> +    {
>> +        "paths": [
>> +            "/run/*"
>> +        ],
>> +        "variant": [
>> +            [
>> +                "/run/s390x",
>> +                [
>> +                    [
>> +                        "/run/s390x",
>> +                        "arch",
>> +                        "s390x"
>> +                    ]
>> +                ]
>> +            ]
>> +        ],
>> +        "variant_id": "s390x"
>> +    },
>> +    {
>> +        "paths": [
>> +            "/run/*"
>> +        ],
>> +        "variant": [
>> +            [
>> +                "/run/x86_64",
>> +                [
>> +                    [
>> +                        "/run/x86_64",
>> +                        "arch",
>> +                        "x86_64"
>> +                    ]
>> +                ]
>> +            ]
>> +        ],
>> +        "variant_id": "x86_64"
>> +    }
>> +]
>>

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
