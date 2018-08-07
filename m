Received: from eggs.gnu.org ([2001:4830:134:3::10]:49124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fn1hk-00035i-5j
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fn1hf-0007iZ-Ff
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:07:16 -0400
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180807125223.GF2556@work-vm> <20180807125819.GP7335@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <00ac9577-52cc-bf48-f0b8-7d15abb2c21f@redhat.com>
Date: Tue, 7 Aug 2018 15:07:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180807125819.GP7335@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, patches@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>, jasowang@redhat.com, qemu-devel@nongnu.org, liqsub1 <liqsub1@163.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable@nongnu.org

On 08/07/2018 02:58 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Aug 07, 2018 at 01:52:24PM +0100, Dr. David Alan Gilbert wrote:
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> The data in an mbuf buffer is not necessarily at the start of the
>>> allocated buffer. (For instance m_adj() allows data to be trimmed
>>> from the start by just advancing the pointer and reducing the length.=
)
>>> This means that the allocated buffer size (m->m_size) and the
>>> amount of space from the m_data pointer to the end of the
>>> buffer (M_ROOM(m)) are not necessarily the same.
>>>
>>> Commit 864036e251f54c9 tried to change the m_inc() function from
>>> taking the new allocated-buffer-size to taking the new room-size,
>>> but forgot to change the initial "do we already have enough space"
>>> check. This meant that if we were trying to extend a buffer which
>>> had a leading gap between the buffer start and the data, we might
>>> incorrectly decide it didn't need to be extended, and then
>>> overrun the end of the buffer, causing memory corruption and
>>> an eventual crash.
>>>
>>> Change the "already big enough?" condition from checking the
>>> argument against m->m_size to checking against M_ROOM().
>>> This only makes a difference for the callsite in m_cat();
>>> the other three callsites all start with a freshly allocated
>>> mbuf from m_get(), which will have m->m_size =3D=3D M_ROOM(m).
>>>
>>> Fixes: 864036e251f54c9
>=20
> IIUC, this changeset was a security fix for CVE-2018-11806.
>=20
> Given that the fix was flawed and allowed guest to crash the host
> with a new buffer overrun, it seems we need to get a new CVE allocated
> too.

But 864036e251f54c9 was never part of an official QEMU release, was it?
Or did it go into a stable release already? If not, I think you simply
need both patches to fix the CVE instead.

 Thomas
