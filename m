Received: from eggs.gnu.org ([2001:4830:134:3::10]:59115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGmSY-0003ET-33
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGmSX-0002y3-7n
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:22:18 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-5-mreitz@redhat.com>
	<20180510075854.GC23581@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9718ca1-d06d-20fc-32c6-ad2425532e5a@redhat.com>
Date: Thu, 10 May 2018 09:22:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180510075854.GC23581@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/13] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 05/10/2018 02:58 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, May 09, 2018 at 06:55:21PM +0200, Max Reitz wrote:
>> Currently, you can give no encryption format for a qcow2 file while
>> still passing a key-secret.  That does not conform to the schema, so
>> this patch changes the schema to allow it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++--=
--
>>   1 file changed, 40 insertions(+), 4 deletions(-)

>>   { 'union': 'BlockdevQcow2Encryption',
>> -  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
>> +  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
>>     'discriminator': 'format',
>> +  'default-variant': 'from-image',
>>     'data': { 'aes': 'QCryptoBlockOptionsQCow',
>> -            'luks': 'QCryptoBlockOptionsLUKS'} }
>> +            'luks': 'QCryptoBlockOptionsLUKS',
>> +            'from-image': 'BlockdevQcow2EncryptionSecret' } }
>=20
> Bike-shedding on name, how about "auto" or "probe" ?

Either of those sounds nicer to me; 'auto' might be better in the=20
context of creation (that way, we can state that creating a NEW image=20
with x-blockdev-create maps 'auto' to 'luks'; while connecting to an=20
EXISTING image maps 'auto' to either 'aes' or 'luks' as appropriate).

>=20
> IIUC, this schema addition means the QAPI parser now allows
>=20
>     encrypt.format=3Dfrom-image,encrypt.key-secret=3Dsec0,...other opts=
...

Yes.  You could, perhaps, add a special case on the command line parsing=20
code to reject an explicit use of format=3Dfrom-image, but the QMP should=
=20
not reject an explicit discriminator.

Hmm, it plays in with my comment on 1/13 - should the QMP parser=20
automatically set has_discriminator to true when it supplies the=20
default?  If it does, you lose the ability to see whether the user=20
supplied an explicit encrypt.format=3Dfrom-image (or the equivalent when=20
using QMP instead of the command line), if you wanted to enforce that=20
the user MUST omit format when relying on the from-image variant.

I don't see a problem in allowing the user to explicitly specify the=20
name of the default branch, but I _do_ think the patch is incomplete for=20
not handling the new QCOW_CRYPT_FROM_IMAGE case and converting it as=20
soon as possible back into one of the other two preferred enum values.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
