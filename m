Received: from eggs.gnu.org ([2001:4830:134:3::10]:60466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gArAm-00075K-DU
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 02:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gArAh-00066i-Co
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 02:43:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47588)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gArAh-000653-0n
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 02:43:39 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181012002217.2864-1-philmd@redhat.com>
	<20181012002217.2864-11-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-11-philmd@redhat.com>
Date: Fri, 12 Oct 2018 09:43:32 +0300
Message-ID: <003301d461f6$e4f29820$aed7c860$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2 10/11] chardev: Let qemu_chr_be_* use
 unsigned type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Prasad J Pandit' <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?'Marc-Andr=C3=A9_Lureau'?= <marcandre.lureau@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
> Since IOCanReadHandler now returns an unsigned value, the assertion
> does not make sense anymore.  We choose however to keep a "fail-safe"
> assertion to catch undesired overflows.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  chardev/char.c          | 17 +++++++++--------
>  include/chardev/char.h  |  9 +++++----
>  include/sysemu/replay.h |  8 ++++----
>  replay/replay-char.c    |  8 ++++----
>  stubs/replay.c          |  8 ++++----
>  5 files changed, 26 insertions(+), 24 deletions(-)
>=20
> diff --git a/chardev/char.c b/chardev/char.c
> index 608c2569f4..ef6d07e132 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -100,7 +100,7 @@ static void qemu_chr_write_log(Chardev *s, const =
uint8_t *buf, size_t len)
>=20
>  static int qemu_chr_write_buffer(Chardev *s,
>                                   const uint8_t *buf, int len,
> -                                 int *offset, bool write_all)
> +                                 size_t *offset, bool write_all)
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
>      int res =3D 0;
> @@ -132,9 +132,10 @@ static int qemu_chr_write_buffer(Chardev *s,
>      return res;
>  }
>=20
> -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool =
write_all)
> +size_t qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len,
> +                      bool write_all)
>  {
> -    int offset =3D 0;
> +    size_t offset =3D 0;
>      int res;
>=20
>      if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
> @@ -156,21 +157,21 @@ int qemu_chr_write(Chardev *s, const uint8_t =
*buf, int len, bool
> write_all)
>      return offset;
>  }
>=20
> -int qemu_chr_be_can_write(Chardev *s)
> +size_t qemu_chr_be_can_write(Chardev *s)
>  {
>      CharBackend *be =3D s->be;
> -    int res;
> +    size_t res;
>=20
>      if (!be || !be->chr_can_read) {
>          return 0;
>      }
>=20
>      res =3D be->chr_can_read(be->opaque);
> -    assert(res >=3D 0);
> +    assert((ssize_t)res >=3D 0); /* "fail-safe" assertion */
>      return res;
>  }
>=20
> -void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len)
> +void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, size_t len)
>  {
>      CharBackend *be =3D s->be;
>=20
> @@ -179,7 +180,7 @@ void qemu_chr_be_write_impl(Chardev *s, uint8_t =
*buf, int len)
>      }
>  }
>=20
> -void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len)
> +void qemu_chr_be_write(Chardev *s, uint8_t *buf, size_t len)
>  {
>      if (qemu_chr_replay(s)) {
>          if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 091a514022..65f93adbd6 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -163,7 +163,7 @@ Chardev *qemu_chr_new_noreplay(const char *label, =
const char *filename,
>   *
>   * Returns: the number of bytes the front end can receive via =
@qemu_chr_be_write
>   */
> -int qemu_chr_be_can_write(Chardev *s);
> +size_t qemu_chr_be_can_write(Chardev *s);
>=20
>  /**
>   * qemu_chr_be_write:
> @@ -174,7 +174,7 @@ int qemu_chr_be_can_write(Chardev *s);
>   * the caller should call @qemu_chr_be_can_write to determine how =
much data
>   * the front end can currently accept.
>   */
> -void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len);
> +void qemu_chr_be_write(Chardev *s, uint8_t *buf, size_t len);
>=20
>  /**
>   * qemu_chr_be_write_impl:
> @@ -183,7 +183,7 @@ void qemu_chr_be_write(Chardev *s, uint8_t *buf, =
int len);
>   *
>   * Implementation of back end writing. Used by replay module.
>   */
> -void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len);
> +void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, size_t len);
>=20
>  /**
>   * qemu_chr_be_update_read_handlers:
> @@ -211,7 +211,8 @@ void qemu_chr_set_feature(Chardev *chr,
>                            ChardevFeature feature);
>  QemuOpts *qemu_chr_parse_compat(const char *label, const char =
*filename,
>                                  bool permit_mux_mon);
> -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool =
write_all);
> +size_t qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len,
> +                      bool write_all);
>  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, =
true)
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>=20
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 7f7a594eca..0856b66888 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -148,17 +148,17 @@ uint64_t blkreplay_next_id(void);
>  /*! Registers char driver to save it's events */
>  void replay_register_char_driver(struct Chardev *chr);
>  /*! Saves write to char device event to the log */
> -void replay_chr_be_write(struct Chardev *s, uint8_t *buf, int len);
> +void replay_chr_be_write(struct Chardev *s, uint8_t *buf, size_t =
len);
>  /*! Writes char write return value to the replay log. */
> -void replay_char_write_event_save(int res, int offset);
> +void replay_char_write_event_save(int res, size_t offset);
>  /*! Reads char write return value from the replay log. */
> -void replay_char_write_event_load(int *res, int *offset);
> +void replay_char_write_event_load(int *res, size_t *offset);
>  /*! Reads information about read_all character event. */
>  int replay_char_read_all_load(uint8_t *buf);
>  /*! Writes character read_all error code into the replay log. */
>  void replay_char_read_all_save_error(int res);
>  /*! Writes character read_all execution result into the replay log. =
*/
> -void replay_char_read_all_save_buf(uint8_t *buf, int offset);
> +void replay_char_read_all_save_buf(uint8_t *buf, size_t offset);
>=20
>  /* Network */
>=20
> diff --git a/replay/replay-char.c b/replay/replay-char.c
> index 736cc8c2e6..9c4ec3c794 100644
> --- a/replay/replay-char.c
> +++ b/replay/replay-char.c
> @@ -49,7 +49,7 @@ void replay_register_char_driver(Chardev *chr)
>      char_drivers[drivers_count++] =3D chr;
>  }
>=20
> -void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
> +void replay_chr_be_write(Chardev *s, uint8_t *buf, size_t len)
>  {
>      CharEvent *event =3D g_malloc0(sizeof(CharEvent));
>=20
> @@ -94,7 +94,7 @@ void *replay_event_char_read_load(void)
>      return event;
>  }
>=20
> -void replay_char_write_event_save(int res, int offset)
> +void replay_char_write_event_save(int res, size_t offset)
>  {
>      g_assert(replay_mutex_locked());
>=20
> @@ -104,7 +104,7 @@ void replay_char_write_event_save(int res, int =
offset)
>      replay_put_dword(offset);
>  }
>=20
> -void replay_char_write_event_load(int *res, int *offset)
> +void replay_char_write_event_load(int *res, size_t *offset)
>  {
>      g_assert(replay_mutex_locked());
>=20
> @@ -150,7 +150,7 @@ void replay_char_read_all_save_error(int res)
>      replay_put_dword(res);
>  }
>=20
> -void replay_char_read_all_save_buf(uint8_t *buf, int offset)
> +void replay_char_read_all_save_buf(uint8_t *buf, size_t offset)
>  {
>      g_assert(replay_mutex_locked());
>      replay_save_instructions();
> diff --git a/stubs/replay.c b/stubs/replay.c
> index 04279abb2c..030f508aef 100644
> --- a/stubs/replay.c
> +++ b/stubs/replay.c
> @@ -34,17 +34,17 @@ void replay_register_char_driver(Chardev *chr)
>  {
>  }
>=20
> -void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
> +void replay_chr_be_write(Chardev *s, uint8_t *buf, size_t len)
>  {
>      abort();
>  }
>=20
> -void replay_char_write_event_save(int res, int offset)
> +void replay_char_write_event_save(int res, size_t offset)
>  {
>      abort();
>  }
>=20
> -void replay_char_write_event_load(int *res, int *offset)
> +void replay_char_write_event_load(int *res, size_t *offset)
>  {
>      abort();
>  }
> @@ -59,7 +59,7 @@ void replay_char_read_all_save_error(int res)
>      abort();
>  }
>=20
> -void replay_char_read_all_save_buf(uint8_t *buf, int offset)
> +void replay_char_read_all_save_buf(uint8_t *buf, size_t offset)
>  {
>      abort();
>  }
> --
> 2.17.1


What about casting to int here:

void replay_event_char_read_run(void *opaque)
{
    CharEvent *event =3D (CharEvent *)opaque;

    qemu_chr_be_write_impl(char_drivers[event->id], event->buf,
                           (int)event->len);

    g_free(event->buf);
    g_free(event);
}



Pavel Dovgalyuk
