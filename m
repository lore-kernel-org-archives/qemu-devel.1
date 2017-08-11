Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgFo7-0002ee-VD
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgFo6-0002Yi-G4
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:41:20 -0400
References: <20170811023759.26390-1-eblake@redhat.com>
	<20170811023759.26390-2-eblake@redhat.com>
	<29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
	<7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
	<c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
Date: Fri, 11 Aug 2017 14:41:08 -0500
MIME-Version: 1.0
In-Reply-To: <c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Iorp7gQhWIjtKbko8uoEt0iC62kk2FtI5"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server
 is detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Iorp7gQhWIjtKbko8uoEt0iC62kk2FtI5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
Subject: Re: [PATCH 1/2] nbd: Drop connection if broken server is detected
References: <20170811023759.26390-1-eblake@redhat.com>
 <20170811023759.26390-2-eblake@redhat.com>
 <29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
 <7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
 <c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
In-Reply-To: <c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 09:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.08.2017 17:15, Eric Blake wrote:
>> On 08/11/2017 02:48 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 11.08.2017 05:37, Eric Blake wrote:
>>>> As soon as the server is sending us garbage, we should quit
>>>> trying to send further messages to the server, and allow all
>>>> pending coroutines for any remaining replies to error out.
>>>> Failure to do so can let a malicious server cause the client
>>>> to hang, for example, if the server sends an invalid magic
>>>> number in its response.

>> The nbd_recv_coroutines_enter_all() call schedules all pending
>> nbd_co_send_request coroutines to fire as soon as the current coroutin=
e
>> reaches a yield point. The next yield point is during the
>> BDRV_POLL_WHILE of nbd_teardown_connection - but this is AFTER we've
>> called qio_channel_shutdown() - so as long as nbd_rwv() is called with=
 a
>> valid ioc, the qio code should recognize that we are shutting down the=

>> connection and gracefully give an error on each write attempt.
>=20
>=20
> Hmm, was it correct even before your patch? Is it safe to enter a corou=
tine
> (which we've scheduled by nbd_recv_coroutines_enter_all()), which is
> actually
> yielded inside nbd_rwv (not our yield in nbd_co_receive_reply)?

I'm honestly not sure how to answer the question. In my testing, I was
unable to catch a coroutine yielding inside of nbd_rwv(); I was able to
easily provoke a situation where the client can send two or more
commands prior to the server getting a chance to reply to either:

=2E/qemu-io -f raw nbd://localhost:10809/foo \
   -c 'aio_read 0 512' -c 'aio_write 1k 1m'

where tracing the server proves that the server received both commands
before sending a reply; when the client sends two aio_read commands, it
was even the case that I could observe the server replying to the second
read before the first.  So I'm definitely provoking parallel coroutines.
 But even without my tentative squash patch, I haven't been able to
observe s->ioc change from valid to NULL within the body of
nbd_co_send_request - either the entire request is skipped because ioc
was already cleared, or the entire request operates on a valid ioc
(although the request may still fail with EPIPE because the ioc has
started its efforts at shutdown).  I even tried varying the size of the
aio_write; with 1M, the client got the write request sent off before the
server's reply; but 2M was large enough that the server sent the read
reply before the client could send the write.  Since we are using a
mutex, we have at most one coroutine able to attempt a write at once;
but that still says nothing about how many other parallel coroutines can
wake up to do a read.  I also think the fact that we are using qio's
set_cork around the paired writes is helping: although we have two calls
to nbd_rwv(), the first one is for the NBD_CMD_WRITE header which is
small that the qio layer waits for the second nbd_rwv() call before
actually sending anything over the wire (if anything, we are more likely
to see s->ioc change before the final set_cork call, rather than between
the two writes - if that change can even happen).

>>
>> I see your point about the fact that coroutines can change hands in
>> between our two writes for an NBD_CMD_WRITE in nbd_co_send_request()
>> (the first write is nbd_send_request() for the header, the second is
>> nbd_rwv() for the data) - if between those two writes we process a
>> failing read, I see your point about us risking re-reading s->ioc as
>=20
> But there are no yields between two writes, so, if previous logic is
> correct,
> if the read fails during first write it will return and error and we
> will not go
> into the second write. If it fails during the second write, it should b=
e
> OK too.

If we can ever observe s->ioc changing to NULL, then my followup squash
patch is needed (if nothing else, calling qio_channel_set_cork(NULL,
false) will crash).  But I'm not familiar enough with coroutines to know
if it is possible, or just paranoia on my part.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Iorp7gQhWIjtKbko8uoEt0iC62kk2FtI5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmOCFQACgkQp6FrSiUn
Q2rvDgf/U5P06vj+/Y+tGxfsx/J6BrvjGZbKvMT19lNYCRTQtGDluOdBN7A2EYzW
liSXZQIb40A1QtimkVWABXLbVQ8huhrzQok/itxnKV/8sxkt21AjPt4wGWRUoRpU
S4RNGkD08ChWXXRD9eT39UcPC1OnUihOsSz39MXatpoO11vMPr9jbk+BOh4GZ+Oi
h/BWfSHhxl8k/PQr6yMZXRNgH6dbPxn4JtVFVFB+h5/+uoIwaqi0JYXATgI/oMm/
I+V3WY3jrjFjoN3NcVWzGztlopNSuuKsXh7bTtVstZhLEOL/yt8j3nk1xHtOpMLn
WgPGRG7Ni8apEQm9ErIPP8kiUKsANw==
=aXRw
-----END PGP SIGNATURE-----

--Iorp7gQhWIjtKbko8uoEt0iC62kk2FtI5--
