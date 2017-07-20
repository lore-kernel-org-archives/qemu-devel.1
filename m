Received: from eggs.gnu.org ([2001:4830:134:3::10]:48024)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYEI4-0006Ck-Mj
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYEI0-00051i-MJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:27:04 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44175 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYEI0-000514-CP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:27:00 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-2-git-send-email-pl@kamp.de>
	<72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <2177e9ee-73c6-cc7d-76a4-e56749be5815@kamp.de>
Date: Thu, 20 Jul 2017 18:26:54 +0200
MIME-Version: 1.0
In-Reply-To: <72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 01/10] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

Am 20.07.2017 um 17:52 schrieb Eric Blake:
> On 07/20/2017 09:20 AM, Peter Lieven wrote:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  docs/interop/qcow2.txt | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> +== Compress format extension ==
>> +
>> +The compress format extension is an optional header extension. It provides
>> +the ability to specify the compress algorithm and compress parameters
>> +that are used for compressed clusters. This new header MUST be present if
>> +the incompatible-feature bit "compress format bit" is set and MUST be absent
>> +otherwise.
>> +
>> +Note: Ommitting the incompatible "Compress format bit" results in the usage
> s/Ommitting/Omitting/
>
>> +of zlib compression with default compression level (default before QEMU 2.10).
>> +However, this old default has a smaller compression window size which results in
>> +lower compression ratio and slightly worse compression speed compared to
>> +explicity specifying zlib compression with default compression level in the
> s/explicity/explicitly/
>
>> +compress format extension.
> If window size affects decompression, then we absolutely must specify
> what window size is in use, both for the old-style compression (bug that
> we haven't mentioned window size in the past), and for the new-style.
> That is, if you have to tell zlib at decompression time what size window
> was used at compression, then our choices for window size should be
> mentioned in this spec.  Furthermore, if window size matters, it sounds
> like it should be a zlib-specific tunable.  I really would like to be
> able to document that having the extension header present with
> parameters XYZ is the same as omitting the extension header (but that is
> only doable if window size is a tunable parameter).
>
> I haven't yet checked your code implementation to see where you are
> setting window sizes, to know if window size is something that should be
> a tunable in the file format.
>
You don't have to know the window size that was used. The docs of zlib

just say, that the windowSize specified at inflate must be greater or equal

to the one used at deflate. So if we change the code to use 15 we can safely

decompress old clusters that where compressed with 12.


Peter
