Received: from eggs.gnu.org ([2001:4830:134:3::10]:49811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGnrM-0004IK-MZ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGnrH-0001ua-OL
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:15:12 -0500
Received: from mail.avalus.com ([89.16.176.221]:57474)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGnrH-0001tB-Em
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:15:07 -0500
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed;
	boundary="Apple-Mail=_20F79DFE-B4D4-4F3C-B1F2-92494BC09ED4";
	protocol="application/pgp-signature"; micalg=pgp-sha512
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161213103700.GD3103@stefanha-x1.localdomain>
Date: Tue, 13 Dec 2016 14:15:05 +0000
Message-Id: <9172729A-8CF6-4C48-A8A2-1194BF40B125@alex.org.uk>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<20161213103700.GD3103@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Stefan stefanha@redhat. com" <stefanha@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>


--Apple-Mail=_20F79DFE-B4D4-4F3C-B1F2-92494BC09ED4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Stefan,

> What about querying "base:" if the NBD spec adds more standard metadata
> contexts in the future?  "base:" does not "uniquely identify a server
> implementation" but it should still be possible to query it so that
> additional contexts can be added to this spec in the future.
> 
> Is the query matching algorithm defined anywhere?  I guess it is
> strncmp(query, context, strlen(query)) but I'm not sure from this text.
> 
> Another common syntax would use an asterisk wildcard ('*') so that it's
> possible to differentiate between full matches and (wildcard) partial
> matches.

I agree. I have suggested a simple string-based left match, which
also fixes ...

>> +        - third-party implementations can register additional
>> +          namespaces by simple request to the mailinglist.
> 
> Does this mean it is possible to activate multiple contexts but only if
> their namespace is identical?  That seems like an arbitrary limitation.
> 
> In other words, the spec suggests you can activate nbd-server:a and
> nbd-server:b but you cannot activate base:a and nbd-server:a.

... this, provided that NBD_SET_META_CONTEXT actually takes a list of
query strings.

> I'd prefer a programming model where the contexts don't need to be set
> for the lifetime of the connection.  Instead the client passes a bitmap
> (64-bits?) of contexts along with each BLOCK_STATUS command.  That way
> the client can select contexts on a per-command basis.  It's unlikely
> that more than 64 contexts need to be available at once but I admit it's
> an arbitrary limitation...
> 
> I guess you've considered this model and decided it's better to
> negotiate upfront, it's wasteful to enable multiple contexts and then
> discard the response data on the client side because only a subset is
> needed for this command invocation.

The issue is that there's nowhere within the current command structure
to put it.

I think the easy way to do this would be to have context IDs as a payload
to the command, like they are with NBD_CMD_WRITE, but the payload
is currently always defined to be of the length specified within the
length section.

The question really is whether we should fix this silly protocol limitation.
I don't think it's as bad as the structured reply fix, and could conceivably
go in there.

--
Alex Bligh





--Apple-Mail=_20F79DFE-B4D4-4F3C-B1F2-92494BC09ED4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYUAJpAAoJEBPm5K7i9iORZEwP/AlCJDYTJIYts5L09PwjlST1
9/VK1nnGNFcmlzAlwe7PrKN+wKUkfYDodGaX8TmbD8Nt6fz2DwVjK94phSu6BGAX
NBdqPs9/NppOoDM4lBNLizJVO4LCDku4VWEYQtkapyg2Vp86eDGmg0B0hKTsmN9z
K3iP2/lW6Fepe5iGKy7ttgeADQ8xURyFLQ2yTM7qDLBpMM+H1eFIa1udnXZmVzni
hcrchqSTSGS2teCNAKFqO0B68olZO+B2vu6FpVt7fKKNTUOMbG2/sWKzu1T3j9QQ
kDKRgug0AXCp+sh/ECcM8qaghjMmNGX50Y+B9Ip+SxL8Mz/xIESxG6YQmnd1qKxd
ZRVIO67nvsDCEs91f3TuCl8HazJN8PoHh+BbzHRgELgVKXgzXrONXKgCBylRszg+
12LI229Oxaquy4hVd/mB4ivvk/msFsvNlu5kggL4ZJBDgtHwbfK3fezSoMl2rOx0
GofPMhEfTxaErJnAjPNlUEsOlONyTq1g7PCrC+vqlQ0QSPhkouSDuEZF1RQuOCTv
1w7T44hwlrq9GkyOWoCqtiAPSkQCBTECll7TYuBbSaDCLGXNoAFB1yEQn1vrGT6y
IrrlmVGctshw52eiirCSFJmC68rxR92p9XB58JO/RqdqKWoS/TNI6eNK2M7Ek94p
AlkzDKpsn9OSIx8b6Xcj
=YvsJ
-----END PGP SIGNATURE-----

--Apple-Mail=_20F79DFE-B4D4-4F3C-B1F2-92494BC09ED4--
